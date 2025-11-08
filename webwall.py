#!/usr/bin/env python3
import sys
import signal
import gi

gi.require_version("Gtk", "3.0")
gi.require_version("WebKit2", "4.0")
gi.require_version("GtkLayerShell", "0.1")

from gi.repository import Gtk, WebKit2, Gdk, GtkLayerShell

def create_window(url, monitor):
    win = Gtk.Window()
    GtkLayerShell.init_for_window(win)
    GtkLayerShell.set_layer(win, GtkLayerShell.Layer.BACKGROUND)
    GtkLayerShell.set_keyboard_interactivity(win, False)

    # Anchor to all edges
    for edge in (
        GtkLayerShell.Edge.TOP,
        GtkLayerShell.Edge.BOTTOM,
        GtkLayerShell.Edge.LEFT,
        GtkLayerShell.Edge.RIGHT,
    ):
        GtkLayerShell.set_anchor(win, edge, True)

    # Attach window to specific monitor
    GtkLayerShell.set_monitor(win, monitor)
    GtkLayerShell.set_exclusive_zone(win, 0)

    # Visual settings
    win.set_app_paintable(True)
    win.set_decorated(False)

    # Monitor size
    geo = monitor.get_geometry()
    win.set_default_size(geo.width, geo.height)

    # Web content
    view = WebKit2.WebView()
    view.load_uri(url)
    win.add(view)
    win.show_all()
    return win

def main(url):
    # Allow exiting with Ctrl+C
    signal.signal(signal.SIGINT, signal.SIG_DFL)

    display = Gdk.Display.get_default()
    if not display:
        raise RuntimeError("Could not get GDK display")

    n = display.get_n_monitors()
    windows = []

    if n > 0:
        for i in range(n):
            monitor = display.get_monitor(i)
            windows.append(create_window(url, monitor))
    else:
        # Fallback if no monitors are detected
        # Create one full-screen window using global resolution
        screen = Gdk.Screen.get_default()
        win = Gtk.Window()
        GtkLayerShell.init_for_window(win)
        GtkLayerShell.set_layer(win, GtkLayerShell.Layer.BACKGROUND)
        GtkLayerShell.set_keyboard_interactivity(win, False)
        for edge in (
            GtkLayerShell.Edge.TOP,
            GtkLayerShell.Edge.BOTTOM,
            GtkLayerShell.Edge.LEFT,
            GtkLayerShell.Edge.RIGHT,
        ):
            GtkLayerShell.set_anchor(win, edge, True)
        win.set_app_paintable(True)
        win.set_decorated(False)
        if screen:
            win.set_default_size(screen.get_width(), screen.get_height())
        view = WebKit2.WebView()
        view.load_uri(url)
        win.add(view)
        win.show_all()
        windows.append(win)

    # Close all when any window is closed
    for w in windows:
        w.connect("destroy", Gtk.main_quit)

    Gtk.main()

if __name__ == "__main__":
    uri = "file:///home/user/media/images/wallpaper/webpaper.html"
    if len(sys.argv) > 1:
        uri = sys.argv[1]
    main(uri)

#execute in hyrpland.conf with: exec-once = bash -lc 'sleep 0.6; python3 ~/.config/hypr/scripts/webwall.py "file:///home/ros/media/images/wallpaper/index.html" &'
