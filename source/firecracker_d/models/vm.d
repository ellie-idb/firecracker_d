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
}

