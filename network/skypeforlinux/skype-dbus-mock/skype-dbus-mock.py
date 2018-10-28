#!/usr/bin/env python
import os
from gi.repository import GLib
import dbus
import dbus.service
import dbus.types
import dbus.mainloop.glib


class FakeLoginManager(dbus.service.Object):

    @dbus.service.method("org.freedesktop.login1.Manager",
                         in_signature='ssss', out_signature='h')
    def Inhibit(self, what, who, why, mode):
        r, w = os.pipe()
        return dbus.types.UnixFd(w)


if __name__ == '__main__':
    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)

    system_bus = dbus.SystemBus()
    bus_name = dbus.service.BusName("org.freedesktop.login1", system_bus)
    obj = FakeLoginManager(system_bus, '/org/freedesktop/login1')

    mainloop = GLib.MainLoop()
    mainloop.run()
