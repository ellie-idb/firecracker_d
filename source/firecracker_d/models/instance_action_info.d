module firecracker_d.models.instance_action_info;
import jsonizer;

/***
* Possible actions that we can do to control our 
* microVM.
***/
enum InstanceActionInfoType : string {
	BlockDeviceRescan = "BlockDeviceRescan",
	InstanceStart = "InstanceStart",
	InstanceHalt = "InstanceHalt"
}
import firecracker_d.models.base_model;

struct InstanceActionInfo {
	mixin JsonizeMe;
	mixin BaseModel;

	/***
	* Action we would like to execute on the microVM
	***/
	@jsonize("action_type", Jsonize.opt) InstanceActionInfoType actionType;

	/***
	* Associated payload with the action
	***/
	@jsonize("payload", Jsonize.opt) string payload;
	


	/***
	  Execute the action via the Firecracker API

	  Throws a FirecrackerException if failed.
	***/
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

