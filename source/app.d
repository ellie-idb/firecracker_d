import std.stdio;
import models.client_models;
import core.client;

void main()
{
	FirecrackerAPIClient client = new FirecrackerAPIClient("/tmp/firecracker.socket");

	Logger l;
	l.logFifo = "/tmp/fc-sb-log";
	l.metricsFifo = "/dev/null";
	l.level = LoggerLevel.Debug;
	l.showLevel = true;
	l.showLogOrigin = false;
	try {
		l.put(client);
	}
	catch(FirecrackerException e) {
		writeln(e.error.faultMessage);
		writeln("Skipping");
	}

	BootSource b;
	b.kernelImagePath = "/home/hatf0/firecracker-demo/vmlinux";
	b.bootArgs = "console=tty6 panic=1 pci=off reboot=k tsc=reliable quiet 8250.nr_uarts=0 ipv6.disable=1 ip=169.254.0.1::169.254.0.2:255.255.255.252::eth0:off";
	b.put(client);

	Drive d;
	d.driveID = "1";
	d.pathOnHost = "/home/hatf0/firecracker-demo/xenial.rootfs.ext4";
	d.isRootDevice = true;
	d.isReadOnly = true;
	d.put(client);

	NetworkInterface n;
	n.ifaceID = "1";
	n.guestMAC = "02:FC:00:00:00:00";
	n.hostDevName = "fc-0-tap0";
	n.state = "Attached";
	n.put(client);

	InstanceActionInfo act;
	act.actionType = InstanceActionInfoType.InstanceStart;
	act.put(client);
	
}
