module firecracker_d.models.drive;
import firecracker_d.models.rate_limiter;
import firecracker_d.models.base_model;

struct Drive {
	mixin JsonizeMe;
	mixin BaseModel;

	@jsonize("drive_id", Jsonize.yes) string driveID;

	@jsonize("is_read_only", Jsonize.yes) bool isReadOnly;

	@jsonize("is_root_device", Jsonize.yes) bool isRootDevice;

	@jsonize("partuuid", Jsonize.opt) string partUUID;

	@jsonize("path_on_host", Jsonize.yes) string pathOnHost;

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

