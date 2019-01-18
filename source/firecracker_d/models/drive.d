module firecracker_d.models.drive;
import firecracker_d.models.rate_limiter;
import firecracker_d.models.base_model;

struct Drive {
	mixin JsonizeMe;
	mixin BaseModel;

	@jsonize("drive_id", Jsonize.yes) string driveID;

	// Is the drive going to be mounted as read-only?
	@jsonize("is_read_only", Jsonize.yes) bool isReadOnly;

	// Is the drive going to be mounted as "/"?
	@jsonize("is_root_device", Jsonize.yes) bool isRootDevice;

	// Represents the unique ID of the boot partition
	// Only used if isRootDevice == true
	@jsonize("partuuid", Jsonize.opt) string partUUID;

	// Where is this drive on the host's file system?
	@jsonize("path_on_host", Jsonize.yes) string pathOnHost;

	// Stop the user from thrashing their disk by rate-limiting it
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

