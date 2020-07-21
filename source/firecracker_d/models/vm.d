module firecracker_d.models.vm;
import firecracker_d.models.base_model;

/***
* Defines the microVM running state. It is especially useful in the snapshotting context.
***/
struct VM {
    mixin BaseModel;

    enum VMState : string {
        paused = "Paused",
        resumed = "Resumed"
    }

    @serializationRequired
    @serializationKeys("state") VMState state;

	/***
    * Updates the microVM state. 
	* Throws: FirecrackerException on error.
	***/
    bool patch(FirecrackerAPIClient cl) {
        Response r = cl.patch("/vm", this.stringify);
        if (r.code == 204) {
            return true;
        } else {
            throwFromResponse(r);
            return false;
        }
    }
}

