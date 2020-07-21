module firecracker_d.models.snapshot;
import firecracker_d.models.base_model;

struct SnapshotCreateParams {
    mixin BaseModel;

    /***
    * Path to the file that will contain the guest memory.
    ***/
    @serializationRequired
    @serializationKeys("mem_file_path") string memFilePath;

    /***
    * Path to the file that will contain the microVM state.
    ***/
    @serializationRequired
    @serializationKeys("snapshot_path") string snapshotPath;

    enum SnapshotTypes : string {
        full = "Full",
        diff = "Diff"
    }

    /***
    * Type of snapshot to create. It is optional and by default, a full snapshot is created.
    ***/
    @serializationKeys("snapshot_type") SnapshotTypes type;

    /***
    * The microVM version for which we want to create the snapshot. It is optional and it defaults to the current version.
    ***/
    @serializationKeys("version") string version_;
}

/***
* Snapshot loading parameters
***/
struct SnapshotLoadParams {
    mixin BaseModel;

    /***
    * Enable support for incremental (diff) snapshots by tracking dirty guest pages.
    ***/
    @serializationKeys("enable_diff_snapshots") bool enableDiffSnapshots;

    /***
    * Path to the file that contains the guest memory to be loaded.
    ***/
    @serializationRequired
    @serializationKeys("mem_file_path") string memFilePath;

    /***
    * Path to the file that contains the microVM state to be loaded.
    ***/
    @serializationRequired
    @serializationKeys("snapshot_path") string snapshotPath;

}

