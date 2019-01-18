module models.machine_configuration;
import jsonizer;
import models.cpu_template;
import models.base_model;

struct MachineConfiguration {
	mixin JsonizeMe;
	mixin BaseModel;

	@jsonize("cpu_template", Jsonize.opt) CPUTemplate cpuTemplate;

	@jsonize("ht_enabled", Jsonize.opt) bool htEnabled;

	@jsonize("mem_size_mib", Jsonize.opt) long memSizeMib;

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
