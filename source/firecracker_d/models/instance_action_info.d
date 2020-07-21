module firecracker_d.models.instance_action_info;
import asdf;

/***
* Possible actions that we can do to control our 
* microVM.
***/
enum InstanceActionInfoType : string {
	InstanceStart = "InstanceStart",
	FlushMetrics = "FlushMetrics",
	SendCtrlAltDel = "SendCtrlAltDel"
}
import firecracker_d.models.base_model;

struct InstanceActionInfo {
	mixin BaseModel;

	/***
	* Action we would like to execute on the microVM
	***/
	@serializationKeys("action_type") InstanceActionInfoType actionType;

	/***
	* Execute the action via the Firecracker API. 
    * Throws: FirecrackerException on error.
	***/
	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/actions", this.stringify);

		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}

}

