module firecracker_d.core.client;
import requests;
import firecracker_d.models.client_models;
import firecracker_d.core.transport;
import std.json;
import jsonizer;

/***
* The base class for our API requests
***/
class FirecrackerAPIClient {
	private {
		Request rq;
		UnixStream factory;
	}

	/***
	* Do an HTTP PUT to the Firecracker server with a given path
	***/
	Response put(string path, string model) {
		Response r = rq.exec!"PUT"("http://localhost" ~ path, model);
		return r;
	}

	/***
	* Do an HTTP PATCH to the firecracker server with a given path
	***/
	Response patch(string path, string model) {
		Response r = rq.exec!"PATCH"("http://localhost" ~ path, model);
		return r;
	}

	/***
	* Do an HTTP GET to the Firecracker server with a given path
	***/
	Response get(string path, string query = "") {
		Response r;
		if(query != "") {
			r = rq.exec!"GET"("http://localhost" ~ path, query);
		}
		else {
			r = rq.exec!"GET"("http://localhost" ~ path);
		}
		return r;
	}

	/***
	* Construct a new instance of the object with the path to the Firecracker's UNIX Socket
	***/
	this(string socketPath) {
		rq = Request();
		factory = new UnixStream();
		factory.setFactorySocket(socketPath);
		rq.socketFactory = &factory.dg;
		rq.addHeaders(["Content-Type": "application/json"]);
	}
}


