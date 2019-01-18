module firecracker_d.models.boot_source;
import jsonizer;
import firecracker_d.models.base_model;

struct BootSource {
	mixin BaseModel;
	mixin JsonizeMe;

	/***
	* Kernel boot arguments
	***/
	@jsonize("boot_args", Jsonize.opt) string bootArgs;

	/***
	* Required: Path to kernel bzImage/vmlinux used to boot guest
	***/
	@jsonize("kernel_image_path", Jsonize.yes) string kernelImagePath;

	/***
	  Create the boot source via the Firecracker API

	  Throws a FirecrackerException if failed.
	***/
	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/boot-source", this.toString);
		
		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}
}

