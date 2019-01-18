module firecracker_d.models.drive;
import firecracker_d.models.rate_limiter;
import firecracker_d.models.base_model;

struct Drive {
	mixin JsonizeMe;
	mixin BaseModel;

	@jsonize("drive_id", Jsonize.yes) string driveID;

	/***
	* Required: bool representing if the disk will be read-only
	***/
	@jsonize("is_read_only", Jsonize.yes) bool isReadOnly;

	/***
	* Required: bool representing if the disk will be mounted as the root partition
	***/
	@jsonize("is_root_device", Jsonize.yes) bool isRootDevice;

	/***
	* Represents the unique ID of the boot partition
	*
	* Only used if `isRootDevice == true`
	***/
	@jsonize("partuuid", Jsonize.opt) string partUUID;

	/***
	* Required: Path to drive on the host's file system
	***/
	@jsonize("path_on_host", Jsonize.yes) string pathOnHost;

	/***
	* Ratelimiter. Intended to stop a user from
	* thrashing our disk, as well as keeping the microVM under
	* control.
	***/
	@jsonize("rate_limiter", Jsonize.opt) RateLimiter rateLimiter; 

	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/drives/" ~ driveID, this.toString);

		if(r.code == 204) {
			return true;
		}
		else {
			FirecrackerError e = FirecrackerError(r.responseBody.toString);
			throw new FirecrackerException(e);
		}
			
	}


}

