const { app, BrowserWindow, Menu, nativeTheme, protocol, session } = require('electron');
const fs = require('fs');
const path = require('path');

// Everything the app needs ships inside this folder (its own Chromium, its own files). Nothing is
// read from the PC it runs on: no system browser component, no local web server or port, no
// Windows file-type registry, no OS light/dark setting. Even Electron's own scratch data is kept
// next to the app instead of in the user's AppData.
app.setPath('userData', path.join(path.dirname(process.execPath), 'userdata'));

const WEB_DIR = path.join(__dirname, '..', 'web');
const ICON = path.join(__dirname, '..', 'icon.ico');

// Fixed file-type table so no file's type is ever guessed from the machine.
const MIME = {
  '.html': 'text/html; charset=utf-8',
  '.js': 'text/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.png': 'image/png',
  '.gltf': 'model/gltf+json',
  '.bin': 'application/octet-stream',
  '.otf': 'font/otf',
  '.woff2': 'font/woff2',
};

nativeTheme.themeSource = 'dark';

// A custom "app://" address served straight from the app's own files, instead of file:// (which
// blocks the 3D loader and module scripts) or a local HTTP server.
protocol.registerSchemesAsPrivileged([
  { scheme: 'app', privileges: { standard: true, secure: true, supportFetchAPI: true, stream: true } },
]);

async function serve(request) {
  let rel = decodeURIComponent(new URL(request.url).pathname);
  if (rel === '/') rel = '/index.html';
  const file = path.normalize(path.join(WEB_DIR, rel));
  if (file !== WEB_DIR && !file.startsWith(WEB_DIR + path.sep)) return new Response('forbidden', { status: 403 });
  try {
    const data = await fs.promises.readFile(file);
    return new Response(data, {
      headers: {
        'Content-Type': MIME[path.extname(file).toLowerCase()] || 'application/octet-stream',
        'Cache-Control': 'no-store',
      },
    });
  } catch {
    return new Response('not found', { status: 404 });
  }
}

let win = null;

function createWindow() {
  // In-memory session (no "persist:" prefix): nothing is cached or stored on disk between runs.
  const ses = session.fromPartition('gearcalc');
  ses.protocol.handle('app', serve);
  // The Export / Import buttons use the clipboard.
  ses.setPermissionRequestHandler((_wc, permission, cb) => cb(permission === 'clipboard-read' || permission === 'clipboard-sanitized-write'));
  ses.setPermissionCheckHandler((_wc, permission) => permission === 'clipboard-read' || permission === 'clipboard-sanitized-write');

  win = new BrowserWindow({
    width: 1280,
    height: 900,
    minWidth: 900,
    minHeight: 650,
    title: 'Gear Calculator',
    icon: ICON,
    backgroundColor: '#1a120b',
    show: false,
    webPreferences: { partition: 'gearcalc', contextIsolation: true, nodeIntegration: false, sandbox: true },
  });
  win.once('ready-to-show', () => win.show());
  win.webContents.setWindowOpenHandler(() => ({ action: 'deny' }));
  win.loadURL('app://gearcalc/index.html');
  win.on('closed', () => { win = null; });
}

if (!app.requestSingleInstanceLock()) {
  app.quit();
} else {
  app.on('second-instance', () => { if (win) { if (win.isMinimized()) win.restore(); win.focus(); } });
  app.whenReady().then(() => {
    Menu.setApplicationMenu(null);
    createWindow();
  });
  app.on('window-all-closed', () => app.quit());
}
