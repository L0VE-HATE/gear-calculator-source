// The one exe the user sees. It carries the whole app (its own Chromium engine, the calculator's
// files) as an embedded zip. First launch on a PC: unpack once into a hidden ".gearcalc" folder
// next to the exe (a small progress window shows while it does). Every launch after that: start
// the unpacked copy straight away. Nothing is installed and nothing depends on the PC.
// Written in plain C# 5 so the compiler built into every Windows can build it.
using System;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.IO.Compression;
using System.Reflection;
using System.Text;
using System.Threading;
using System.Windows.Forms;

static class Launcher
{
    static string Read(Assembly asm, string name)
    {
        using (Stream s = asm.GetManifestResourceStream(name))
        using (StreamReader r = new StreamReader(s))
            return r.ReadToEnd().Trim();
    }

    // Prefer a hidden folder beside the exe; if that place can't be written to (read-only
    // drive, protected folder), fall back to a per-user folder.
    static string PickRoot(string exeDir)
    {
        string beside = Path.Combine(exeDir, ".gearcalc");
        try
        {
            Directory.CreateDirectory(beside);
            string probe = Path.Combine(beside, "write-test.tmp");
            File.WriteAllText(probe, "x");
            File.Delete(probe);
            return beside;
        }
        catch { }
        string fallback = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "GearCalculator");
        Directory.CreateDirectory(fallback);
        return fallback;
    }

    static void Unpack(Assembly asm, string root, string dir)
    {
        string tmp = dir + ".unpacking";
        if (Directory.Exists(tmp)) Directory.Delete(tmp, true);
        Directory.CreateDirectory(tmp);
        string tmpFull = Path.GetFullPath(tmp) + Path.DirectorySeparatorChar;

        using (Stream s = asm.GetManifestResourceStream("app.zip"))
        using (ZipArchive zip = new ZipArchive(s, ZipArchiveMode.Read))
        {
            foreach (ZipArchiveEntry e in zip.Entries)
            {
                string dest = Path.GetFullPath(Path.Combine(tmp, e.FullName));
                if (!dest.StartsWith(tmpFull, StringComparison.OrdinalIgnoreCase)) continue; // never write outside the target
                if (e.FullName.EndsWith("/"))
                {
                    Directory.CreateDirectory(dest);
                    continue;
                }
                Directory.CreateDirectory(Path.GetDirectoryName(dest));
                e.ExtractToFile(dest, true);
            }
        }
        File.WriteAllText(Path.Combine(tmp, "ready.txt"), "ok");
        if (Directory.Exists(dir)) Directory.Delete(dir, true);
        Directory.Move(tmp, dir);

        // Older unpacked versions are no longer needed.
        foreach (string d in Directory.GetDirectories(root))
        {
            if (!string.Equals(Path.GetFileName(d), Path.GetFileName(dir), StringComparison.OrdinalIgnoreCase))
            {
                try { Directory.Delete(d, true); } catch { }
            }
        }
        try { File.SetAttributes(root, File.GetAttributes(root) | FileAttributes.Hidden); } catch { }
    }

    class ProgressForm : Form
    {
        public ProgressForm()
        {
            Text = "Gear Calculator";
            FormBorderStyle = FormBorderStyle.FixedDialog;
            MaximizeBox = false;
            MinimizeBox = false;
            StartPosition = FormStartPosition.CenterScreen;
            TopMost = true;
            ClientSize = new Size(420, 96);
            BackColor = Color.FromArgb(26, 18, 11);
            ForeColor = Color.FromArgb(244, 231, 210);
            Label l = new Label();
            l.Text = "Getting Gear Calculator ready (first launch only)...";
            l.AutoSize = false;
            l.Left = 16; l.Top = 18; l.Width = 388; l.Height = 24;
            l.Font = new Font("Segoe UI", 10f);
            Controls.Add(l);
            ProgressBar p = new ProgressBar();
            p.Style = ProgressBarStyle.Marquee;
            p.MarqueeAnimationSpeed = 30;
            p.Left = 16; p.Top = 52; p.Width = 388; p.Height = 18;
            Controls.Add(p);
        }
    }

    [STAThread]
    static int Main(string[] args)
    {
        Application.EnableVisualStyles();
        Assembly asm = Assembly.GetExecutingAssembly();
        string exeDir = Path.GetDirectoryName(asm.Location);
        string buildId = Read(asm, "build_id.txt");

        bool createdNew;
        using (Mutex m = new Mutex(true, "GearCalculatorUnpack-" + buildId, out createdNew))
        {
            if (!createdNew) m.WaitOne(); // another launch is already unpacking; wait for it, then reuse it

            string root = PickRoot(exeDir);
            string dir = Path.Combine(root, buildId);
            if (!File.Exists(Path.Combine(dir, "ready.txt")))
            {
                Exception err = null;
                ProgressForm form = new ProgressForm();
                Thread worker = new Thread(delegate ()
                {
                    try { Unpack(asm, root, dir); }
                    catch (Exception ex) { err = ex; }
                    try { form.BeginInvoke(new MethodInvoker(form.Close)); } catch { }
                });
                form.Shown += delegate { worker.Start(); };
                Application.Run(form);
                worker.Join();
                if (err != null)
                {
                    MessageBox.Show("Gear Calculator couldn't unpack itself:\n\n" + err.Message, "Gear Calculator");
                    try { m.ReleaseMutex(); } catch { }
                    return 1;
                }
            }
            try { m.ReleaseMutex(); } catch { }

            StringBuilder a = new StringBuilder();
            foreach (string s in args) a.Append('"').Append(s.Replace("\"", "\\\"")).Append("\" ");
            ProcessStartInfo psi = new ProcessStartInfo(Path.Combine(dir, "Gear Calculator.exe"), a.ToString().Trim());
            psi.WorkingDirectory = dir;
            psi.UseShellExecute = false;
            Process.Start(psi);
        }
        return 0;
    }
}
