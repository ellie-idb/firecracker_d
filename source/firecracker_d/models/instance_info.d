module firecracker_d.models.instance_info;
import asdf;
import firecracker_d.models.base_model;

struct InstanceInfo {
	mixin BaseModel;

	/***
	*  Possible states that our microVM could be in
	***/
	enum InstanceState : string {
		Uninitialized = "Uninitialized",
		Starting = "Starting",
		Running = "Running",
	}

    /***
    * Application name (?)
    ***/
    @serializationKeys("app_name") string appName;

	/***
	* ID of our current microVM
	***/
	@serializationKeys("id") string id;

	/***
	* State of our current microVM
	***/
	@serializationKeys("state") InstanceState state;

    /***
    * MicroVM hypervisor version
    ***/
    @serializationKeys("vmm_version") string vmmVersion;

	/***
	* Get the microVM's state via the Firecracker API. 
    * Throws: FirecrackerException on error.
	***/
	this(FirecrackerAPIClient cl) {
		Response r = cl.get("/");

		if(r.code == 200) {
			InstanceInfo k = r.responseBody.toString.deserialize!InstanceInfo();
			this = k;
		}
		else {
			throwFromResponse(r);
		}
	}

}
