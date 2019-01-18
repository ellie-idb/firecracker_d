module firecracker_d.core.client;
import requests;
import firecracker_d.models.client_models;
import firecracker_d.core.transport;
import std.json;
import jsonizer;

class FirecrackerAPIClient {
	private {
		Request rq;
		UnixStream factory;
	}

	Response put(string path, string model) {
		Response r = rq.exec!"PUT"("http://localhost" ~ path, model);
		return r;
	}

	Response get(string path, string query = "") {
		Response r = rq.exec!"GET"("http://localhost" ~ path);
		return r;
	}


	this(string socketPath) {
		rq = Request();
		factory = new UnixStream();
		factory.setFactorySocket(socketPath);
		rq.socketFactory = &factory.dg;
		rq.addHeaders(["Content-Type": "application/json"]);
	}
}


