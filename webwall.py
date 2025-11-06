#!/usr/bin/env python3
import sys
import gi
gi.require_version("Gtk", "3.0")
gi.require_version("WebKit2", "4.0")
gi.require_version("GtkLayerShell", "0.1")
from gi.repository import Gtk, WebKit2, Gdk, GtkLayerShell

def main(url):
    win = Gtk.Window()
    GtkLayerShell.init_for_window(win)
    GtkLayerShell.set_layer(win, GtkLayerShell.Layer.BACKGROUND)
    GtkLayerShell.set_keyboard_interactivity(win, False)
    for edge in (GtkLayerShell.Edge.TOP, GtkLayerShell.Edge.BOTTOM,
                 GtkLayerShell.Edge.LEFT, GtkLayerShell.Edge.RIGHT):
        GtkLayerShell.set_anchor(win, edge, True)

    screen = Gdk.Screen.get_default()
    win.set_app_paintable(True)
    win.set_decorated(False)
    win.set_size_request(screen.get_width(), screen.get_height())

    view = WebKit2.WebView()
    view.load_uri(url)
    win.add(view)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    uri = "file:///home/ros/media/images/wallpaper/index.html"
    if len(sys.argv) > 1:
        uri = sys.argv[1]
    main(uri)

