module firecracker_d.models.logger;
import asdf;

/***
* Verbosity levels for the logger
***/
enum LoggerLevel : string {
		Error = "Error",
		Warning = "Warning",
		Info = "Info",
		Debug = "Debug"
}
import firecracker_d.models.base_model;

struct Logger {
	mixin BaseModel;

	/***
	* Verbosity level for our logger
	***/
	@serializationKeys("level") LoggerLevel level;

	/***
	* Output location for the log
	*
	* Can be a named pipe, or the path to a file
	***/
	@serializationKeys("log_path") string logPath;

	/***
	* Option to show the level of individual events in the
	* log file.
	***/
	@serializationKeys("show_level") bool showLevel;

	/***
	* Option to show the origin of where log events originate
	* from.
	***/
	@serializationKeys("show_log_origin") bool showLogOrigin;

	/***
	  Create the logger via the Firecracker API

	  Throws a FirecrackerException if failed.
	***/

	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/logger", this.stringify);
		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}
}
