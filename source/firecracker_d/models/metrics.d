module firecracker_d.models.metrics;
import asdf;
import firecracker_d.models.base_model;

/***
* Describes the configuration option for the metrics capability.
***/
struct Metrics {
    mixin BaseModel;

    /***
    * Path to the named pipe or file where the JSON-formatted metrics are flushed.
    ***/
    @serializationKeys("metrics_path") @serializationRequired string metricsPath;

	/***
	* Create the metrics object via the Firecracker API
    * Throws: FirecrackerException
	***/
	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/metrics", this.stringify);
		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}
}




