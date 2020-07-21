module firecracker_d.models.boot_source;
import asdf;
import firecracker_d.models.base_model;

struct BootSource {
    mixin BaseModel;

	/***
	* Kernel boot arguments
	***/
	@serializationKeys("boot_args") string bootArgs;

    /***
    * Host level path to initrd image used to boot guest
    ***/
    @serializationKeys("initrd_path") string initrdPath;

	/***
	* Host level path to kernel bzImage/vmlinux used to boot guest
	***/
	@serializationRequired 
    @serializationKeys("kernel_image_path") string kernelImagePath;

	/***
	* Create the boot source via the Firecracker API
    * Throws: FirecrackerException
	***/
	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/boot-source", this.stringify);
		
		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}
}

