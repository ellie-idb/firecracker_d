module firecracker_d.models.machine_configuration;
import firecracker_d.models.cpu_template;
import asdf;
import firecracker_d.models.base_model;

struct MachineConfiguration {
	mixin BaseModel;

	/***
	* CPU Template to use for default options
	***/
	@serializationKeys("cpu_template") CPUTemplate cpuTemplate;

	/***
	* Option to enable hyperthreading for the guest
	***/
	@serializationKeys("ht_enabled") bool htEnabled;

	/***
	* Integer representing the guest's memory size in MiB
	***/
	@serializationKeys("mem_size_mib") long memSizeMib;

	/***
	* Integer representing the amount of vCPUs given to the guest
	***/
	@serializationKeys("vcpu_count") long vcpuCount;

	/***
	  Modify the microVM's configuration via the Firecracker API

	  Throws a FirecrackerException if failed.
	***/

	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/machine-config", this.stringify);

		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}

	/***
	  Get the microVM's config via the Firecracker API

	  Throws a FirecrackerException if failed.
	***/

	this(FirecrackerAPIClient cl) {
		Response r = cl.get("/machine-config");
		if(r.code == 200) {
			MachineConfiguration m = r.responseBody.toString.deserialize!MachineConfiguration();
			this = m;
		}
		else {
			throwFromResponse(r);
		}
	}

}
