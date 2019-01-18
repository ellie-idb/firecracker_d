import std.stdio;
import jsonizer;
import firecracker_d.models.client_models;
import std.json;

unittest {

	writeln("testing deserialization of all models.");

	string bootSource_test = `{"boot_args": "hello", "kernel_image_path": "world"}`;
	JSONValue bootSource_test_json = bootSource_test.parseJSON;

	BootSource bootSource = bootSource_test_json.fromJSON!BootSource;

	assert(bootSource.bootArgs == "hello", "boot args was not properly deserialized..");

	assert(bootSource.kernelImagePath == "world", "kernel image path was not properly deserialized");
		

	string drive_test = `{"drive_id": "test", "is_read_only": true, "is_root_device": true, "partuuid": "123", "path_on_host": "/", "rate_limiter": {"bandwidth": {"size": 0, "one_time_burst": 1, "refill_time": 1}, "ops": {"size": 123, "one_time_burst": 456, "refill_time": 789}}}`;
	JSONValue drive_test_json = drive_test.parseJSON;

	Drive drive = drive_test_json.fromJSON!Drive;

	assert(drive.driveID == "test", "drive id was not properly deserialized");
	assert(drive.isReadOnly, "drive read only state was not properly deserialized");
	assert(drive.isRootDevice, "drive root device state was not properly deserialized");
	assert(drive.partUUID == "123", "drive part UUID was not properly deserialized");

	assert(drive.pathOnHost == "/", "drive path on host was not properly deserialized");

	assert(drive.rateLimiter.bandwidth.size == 0, "rate limiter was not properly deserialized");
	assert(drive.rateLimiter.bandwidth.oneTimeBurst == 1, "rate limiter was not properly deserialized");
	assert(drive.rateLimiter.bandwidth.refillTime == 1, "rate limiter was not properly deserialized");
	assert(drive.rateLimiter.ops.size == 123, "rate limiter was not properly deserialized");
	assert(drive.rateLimiter.ops.oneTimeBurst == 456, "rate limiter was not properly deserialized");
	assert(drive.rateLimiter.ops.refillTime == 789, "rate limiter was not properly deserialized");

	string instance_action_info_test = `{"action_type": "BlockDeviceRescan", "payload": "hello"}`;
	JSONValue instance_action_info_json = instance_action_info_test.parseJSON;

	InstanceActionInfo instance_action_info = instance_action_info_json.fromJSON!InstanceActionInfo;

	assert(instance_action_info.actionType == InstanceActionInfoType.BlockDeviceRescan, "instance action info was not properly deserialized");




}

