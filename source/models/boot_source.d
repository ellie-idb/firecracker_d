module models.boot_source;
import jsonizer;
import models.base_model;

struct BootSource {
	mixin BaseModel;
	mixin JsonizeMe;
	// Optional
	// Kernel boot arguments
	@jsonize("boot_args", Jsonize.opt) string bootArgs;

	// Non-optional
	// Path to kernel image used to boot guest
	@jsonize("kernel_image_path", Jsonize.yes) string kernelImagePath;

	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/boot_source", this.toString);
		
		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}
}

