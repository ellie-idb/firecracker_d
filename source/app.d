import std.stdio;
import jsonizer;
import models.client_models;
import std.json;
import requests;
import std.socket;
import core.transport;
import core.client;

void main()
{
	FirecrackerAPIClient client = new FirecrackerAPIClient("/tmp/firecracker.socket");
	
	writeln(client.InstanceInfo.state);

	writeln(client.MachineConfiguration.cpuTemplate);
	writeln(client.MachineConfiguration.htEnabled);
	writeln(client.MachineConfiguration.memSizeMib);
	writeln(client.MachineConfiguration.vcpuCount);

	

}
