module firecracker_d.models.instance_action_info;
import asdf;

/***
* Possible actions that we can do to control our 
* microVM.
***/
enum InstanceActionInfoType : string {
	BlockDeviceRescan = "BlockDeviceRescan",
	InstanceStart = "InstanceStart",
//	InstanceHalt = "InstanceHalt",
	FlushMetrics = "FlushMetrics",
	Reboot = "SendCtrlAltDel"
}
import firecracker_d.models.base_model;

struct InstanceActionInfo {
	mixin BaseModel;

	/***
	* Action we would like to execute on the microVM
	***/
	@serializationKeys("action_type") InstanceActionInfoType actionType;

	/***
	* Associated payload with the action
	***/
	@serializationKeys("payload") string payload;

	/***
	  Execute the action via the Firecracker API

	  Throws a FirecrackerException if failed.
	***/
	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/actions", this.stringify);

        import std.stdio : writeln;
        writeln("put json: " ~ this.stringify);

		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}

}

