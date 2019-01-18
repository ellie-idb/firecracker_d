module firecracker_d.models.boot_source;
import jsonizer;
import firecracker_d.models.base_model;

/***
* Boot Source from the Go API
* This provides the microVM with the kernel boot arguments
* as well as the vmlinux/vmlinuz/bzImage binary needed 
* to boot the kernel.
***/
struct BootSource {
	mixin BaseModel;
	mixin JsonizeMe;
	/***
	* Optional
	* Kernel boot arguments
	***/
	@jsonize("boot_args", Jsonize.opt) string bootArgs;

	/***
	* Non-optional
	* Path to kernel image used to boot guest
	***/
	@jsonize("kernel_image_path", Jsonize.yes) string kernelImagePath;

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

