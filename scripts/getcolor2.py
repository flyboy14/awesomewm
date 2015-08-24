#!/bin/python2

from PIL import Image
from sys import argv

my_x = int(argv[1])
my_y = int(argv[2])

def rgb2hex(r, g, b):
    return '#{:02x}{:02x}{:02x}'.format(r, g, b)

def get_pixel_color(i_x, i_y):
    import gtk # python-gtk2
    o_gdk_pixbuf = gtk.gdk.Pixbuf(gtk.gdk.COLORSPACE_RGB, False, 8, 1, 1)
    o_gdk_pixbuf.get_from_drawable(gtk.gdk.get_default_root_window(), gtk.gdk.colormap_get_system(), i_x, i_y, 0, 0, 1, 1)
    return tuple(o_gdk_pixbuf.get_pixels_array().tolist()[0][0])
clist = get_pixel_color(my_x, my_y)
print rgb2hex(clist[0], clist[1], clist[2])
