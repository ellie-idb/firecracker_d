module firecracker_d.models.machine_configuration;
import jsonizer;
import firecracker_d.models.cpu_template;
import firecracker_d.models.base_model;

struct MachineConfiguration {
	mixin JsonizeMe;
	mixin BaseModel;

	// What should we base the machine's configuration off of?
	@jsonize("cpu_template", Jsonize.opt) CPUTemplate cpuTemplate;

	// Is hyperthreading enabled?
	@jsonize("ht_enabled", Jsonize.opt) bool htEnabled;

	// Machine's allocated memory size in MiB
	@jsonize("mem_size_mib", Jsonize.opt) long memSizeMib;

	// How many vCPUs should we allocate to this box?
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
