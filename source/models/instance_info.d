module models.instance_info;
import jsonizer;
import models.base_model;

struct InstanceInfo {
	mixin JsonizeMe;
	mixin BaseModel;

	enum InstanceState : string {
		Uninitialized = "Uninitialized",
		Starting = "Starting",
		Running = "Running",
		Halting = "Halting",
		Halted = "Halted"
	}

	@jsonize("id", Jsonize.opt) string id;

	@jsonize("state", Jsonize.opt) InstanceState state;

	this(FirecrackerAPIClient cl) {
		Response r = cl.get("/");

		if(r.code == 200) {
			InstanceInfo k = r.responseBody.toString.parseJSON.fromJSON!InstanceInfo;
			this = k;
		}
		else {
			throwFromResponse(r);
		}
	}

}
