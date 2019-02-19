module firecracker_d.models.error;
import firecracker_d.models.base_model;

/*
   This file is kind of a mess, but it wraps a FirecrackerError
   in a D exception, so we can have try-catch bodies whenever we're
   pushing the models to the Firecracker server.
*/

struct FirecrackerError {
	@serializationKeys("fault_message") string faultMessage;

	this(string responseBody) {
		faultMessage = responseBody.deserialize!FirecrackerError.faultMessage;
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

