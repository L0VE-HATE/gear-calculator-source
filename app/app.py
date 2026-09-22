import http.server
import os
import socket
import sys
import threading

import webview


def resource_path(relative):
    base = getattr(sys, "_MEIPASS", os.path.dirname(os.path.abspath(__file__)))
    return os.path.join(base, relative)


def free_port():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind(("127.0.0.1", 0))
    port = s.getsockname()[1]
    s.close()
    return port


class GearCalcServer(http.server.ThreadingHTTPServer):
    # Loading one weapon's 3D parts fires up to ~16 simultaneous requests (a .gltf +
    # .bin per part, across up to 8 slots) - the base class's default backlog of 5
    # can't hold that many pending connections, so extra ones get refused outright
    # (ERR_CONNECTION_REFUSED) instead of just queuing and waiting their turn.
    request_queue_size = 64


# The stock handler asks Python's mimetypes module for each file's type, and on Windows that
# module reads the machine's registry - a PC where some other program registered .js as
# text/plain makes the browser engine refuse to run our module scripts. Every file type this
# app ships is listed here so nothing depends on the machine it runs on.
MIME_TYPES = {
    ".html": "text/html; charset=utf-8",
    ".js": "text/javascript; charset=utf-8",
    ".json": "application/json; charset=utf-8",
    ".css": "text/css; charset=utf-8",
    ".png": "image/png",
    ".gltf": "model/gltf+json",
    ".bin": "application/octet-stream",
    ".otf": "font/otf",
    ".woff2": "font/woff2",
}


class GearCalcHandler(http.server.SimpleHTTPRequestHandler):
    def guess_type(self, path):
        return MIME_TYPES.get(os.path.splitext(str(path))[1].lower(), "application/octet-stream")

    def end_headers(self):
        # Never let the browser engine reuse an older copy of any file from a previous version.
        self.send_header("Cache-Control", "no-store")
        super().end_headers()

    def log_message(self, format, *args):
        # The default writes every request to stderr, which doesn't exist (or may be a
        # closed pipe) in a windowed exe - a failed write there aborts the request itself.
        pass


def start_server(directory, port):
    handler = lambda *a, **kw: GearCalcHandler(*a, directory=directory, **kw)
    httpd = GearCalcServer(("127.0.0.1", port), handler)
    thread = threading.Thread(target=httpd.serve_forever, daemon=True)
    thread.start()
    return httpd


AUTOLOAD_BUILD = os.environ.get("GEARCALC_AUTOLOAD", "").strip()

AUTOLOAD_JS = """
(function(){
  var label = %s;
  if (!label) return;
  var tryClick = function(){
    var btn = Array.prototype.find.call(document.querySelectorAll('.chip'),
      function(b){ return b.textContent.trim() === label; });
    if (btn) { btn.click(); return true; }
    return false;
  };
  if (!tryClick()) {
    var tries = 0;
    var iv = setInterval(function(){
      tries++;
      if (tryClick() || tries > 40) clearInterval(iv);
    }, 100);
  }
})();
"""


def main():
    web_dir = resource_path("web")
    port = free_port()
    start_server(web_dir, port)
    window = webview.create_window(
        "Gear Calculator",
        f"http://127.0.0.1:{port}/index.html",
        width=1280,
        height=900,
        min_size=(900, 650),
    )
    if AUTOLOAD_BUILD:
        import json

        script = AUTOLOAD_JS % json.dumps(AUTOLOAD_BUILD)
        window.events.loaded += lambda: window.evaluate_js(script)

    try:
        webview.start()
    except Exception as exc:
        import ctypes

        ctypes.windll.user32.MessageBoxW(
            0,
            "Gear Calculator couldn't start its rendering engine.\n\n"
            f"{exc}\n\n"
            "Try reinstalling the app, or install the Microsoft Edge WebView2 "
            "Runtime from https://developer.microsoft.com/microsoft-edge/webview2/",
            "Gear Calculator - Startup Error",
            0x10,  # MB_ICONERROR
        )
        raise


if __name__ == "__main__":
    main()
