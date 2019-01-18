module firecracker_d.models.instance_action_info;
import jsonizer;

enum InstanceActionInfoType : string {
	BlockDeviceRescan = "BlockDeviceRescan",
	InstanceStart = "InstanceStart",
	InstanceHalt = "InstanceHalt"
}
import firecracker_d.models.base_model;

struct InstanceActionInfo {
	mixin JsonizeMe;
	mixin BaseModel;

	// One of three actions that is meant to control the microVM
	@jsonize("action_type", Jsonize.opt) InstanceActionInfoType actionType;

	// If there is an associated payload with the action, it is
	// placed here.
	@jsonize("payload", Jsonize.opt) string payload;
	

	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/actions", this.toString);

		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}



}

