module firecracker_d.models.partial_drive;
import firecracker_d.models.base_model;

/*** 
*  Unused, and mostly undocumented..
***/

struct PartialDrive {
	mixin BaseModel;

    @serializationRequired
	@serializationKeys("drive_id") string driveID;

    @serializationRequired
	@serializationKeys("path_on_host") string pathOnHost;
}
