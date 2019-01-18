module firecracker_d.models.machine_configuration;
import jsonizer;
import firecracker_d.models.cpu_template;
import firecracker_d.models.base_model;

struct MachineConfiguration {
	mixin JsonizeMe;
	mixin BaseModel;

	/***
	* CPU Template to use for default options
	***/
	@jsonize("cpu_template", Jsonize.opt) CPUTemplate cpuTemplate;

	/***
	* Option to enable hyperthreading for the guest
	***/
	@jsonize("ht_enabled", Jsonize.opt) bool htEnabled;

	/***
	* Integer representing the guest's memory size in MiB
	***/
	@jsonize("mem_size_mib", Jsonize.opt) long memSizeMib;

	/***
	* Integer representing the amount of vCPUs given to the guest
	***/
	@jsonize("vcpu_count", Jsonize.opt) long vcpuCount;

	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/machine-config", this.toString);

		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}

	this(FirecrackerAPIClient cl) {
		Response r = cl.get("/machine-config");
		if(r.code == 200) {
			MachineConfiguration m = r.responseBody.toString.parseJSON.fromJSON!MachineConfiguration;
			this = m;
		}
		else {
			throwFromResponse(r);
		}
	}


}
