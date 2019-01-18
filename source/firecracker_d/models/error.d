module firecracker_d.models.error;
import jsonizer;
import firecracker_d.models.base_model;

struct FirecrackerError {
	mixin JsonizeMe;
	@jsonize("fault_message", Jsonize.opt) string faultMessage;

	this(string responseBody) {
		import std.json : parseJSON;
		faultMessage = responseBody.parseJSON().fromJSON!FirecrackerError.faultMessage;
	}
}

class FirecrackerException : Exception {
public:
	FirecrackerError error;

    this(FirecrackerError e, string file = __FILE__, size_t line = __LINE__) {
	    error = e;
        super(e.faultMessage, file, line);
    }
}

import requests;
void throwFromResponse(Response r, string file = __FILE__, size_t line = __LINE__) {
	FirecrackerError e = FirecrackerError(r.responseBody.toString);
	throw new FirecrackerException(e, file, line);
}

