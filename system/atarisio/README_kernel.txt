*******************************************************************
* If your serial port is a USB adaptor, STOP reading this NOW and *
* go build atarisio _without_ KERNEL="yes"!                       *
*******************************************************************

AtariSIO's atariserver and atarixfer use your serial (RS232) port to
communicate with the SIO2PC device. This can be done one of two ways:
using the regular Linux serial port driver or a special AtariSIO
kernel driver that "takes over" the serial port [1].

The kernel driver exists because the SIO protocol relies on tight
timing, especially when using high bitrates (lower POKEY divisor
numbers). On older machines, scheduling latency can cause "hiccups"
in the SIO transfers, resulting in slow loading (due to retries)
or failures.

On modern machines (especially with modern kernels), there's less of
a need for the kernel driver. Also, modern computers don't often have
real serial ports. It's still possible to use AtariSIO with a USB to
RS232 adaptor on such a machine, but not with the kernel module.

The AtariSIO kernel driver can only be used if you have a real (not
USB) serial port that uses a 16550A or 100% compatible UART. If you're
using USB, stop reading this and build atarisio without KERNEL=yes.

Also, even if you do have a real 16550A serial port, you still might
want to avoid the kernel driver: if atarisio works fine without it,
there's no need for the kernel driver's extra complexity.

If you're determined to use the kernel driver, read on.

1. Build atarisio with KERNEL=yes [2].

2. Install the atarisio package you just built.

3. The atarisio module needs to know which serial port to use. The
   default is /dev/ttyS0. If you only have one serial port, this
   should be the correct one. If you need to change this, edit
   /etc/modprobe.d/atarisio.conf and change the "port=/dev/ttyS0" to
   whatever it should be.

4. As root, run "modprobe atarisio". The module will be loaded on
   every boot; this step is just to avoid rebooting. If you don't
   want to load the module at boot, edit /etc/rc.d/rc.modules.local
   and comment out the "/sbin/modprobe atarisio" line.

At this point, you should be ready to run atarisio. If you have
trouble with the kernel module, try building atarisio without it and
see if it works. If not, there's probably something wrong with your
hardware.

Notes:

[1] The SlackBuild author hasn't tested the kernel module. I don't
    currently own any machines with 16550A serial ports, only USB.
    I used to use the kernel module with older hardware (up to 2016
    or so) and it worked fine then.

[2] If building the kernel module fails, it means your kernel is too
    new for atarisio. The current version of atarisio works with
    kernels up to 5.15.x (which is what Slackware 15.0 runs). If
    you're running Slackware-current and can't compile the kernel
    module, tough luck (for now anyway). Use atarisio without the
    kernel module, or use Slackware 15.0.
