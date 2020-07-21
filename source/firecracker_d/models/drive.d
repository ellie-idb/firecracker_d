module firecracker_d.models.drive;
import firecracker_d.models.rate_limiter;
import firecracker_d.models.base_model;

struct Drive {
	mixin BaseModel;

	@serializationRequired @serializationKeys("drive_id") string driveID;

	/***
	* Required: bool representing if the disk will be read-only
	***/
	@serializationRequired @serializationKeys("is_read_only") bool isReadOnly;

	/***
	* Required: bool representing if the disk will be mounted as the root partition
	***/
    @serializationRequired 
	@serializationKeys("is_root_device") bool isRootDevice;

	/***
	* Represents the unique ID of the boot partition
	*
	* Only used if `isRootDevice == true`
	***/
	@serializationKeys("partuuid") string partUUID;

	/***
	* Required: Path to drive on the host's file system
	***/
	@serializationRequired 
    @serializationKeys("path_on_host") string pathOnHost;

	/***
	* Ratelimiter. Intended to stop a user from
	* thrashing our disk, as well as keeping the microVM under
	* control.
	***/
	@serializationKeys("rate_limiter") RateLimiter rateLimiter; 

	/***
	* Create the drive via the Firecracker API. 
    * Throws: FirecrackerException on error.
	***/
	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/drives/" ~ driveID, this.stringify);

		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
			
	}
}

/*** 
* Used to update drive information after microvm start?
***/
struct PartialDrive {
	mixin BaseModel;
    /***
    * Firecracker ID for drive
    ***/
    @serializationRequired
	@serializationKeys("drive_id") string driveID;

    /***
    * Host level path for guest drive
    ***/
    @serializationRequired
	@serializationKeys("path_on_host") string pathOnHost;

	/***
	* Modify the drive via the Firecracker API
    * Post-boot only
    * Throws: FirecrackerException
	***/
	bool patch(FirecrackerAPIClient cl) {
		Response r = cl.patch("/drives/" ~ driveID, this.stringify);
		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}

}
