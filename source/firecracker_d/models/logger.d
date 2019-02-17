module firecracker_d.models.logger;
import jsonizer;

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
	mixin JsonizeMe;
	mixin BaseModel;

	/***
	* Verbosity level for our logger
	***/
	@jsonize("level", Jsonize.opt) LoggerLevel level;

	/***
	* Output location for the log
	*
	* Can be a named pipe, or the path to a file
	***/
	@jsonize("log_fifo", Jsonize.opt) string logFifo;

	/***
	* Output location for the VM's metrics
	*
	* Can be a named pipe, or the path to a file
	***/
	@jsonize("metrics_fifo", Jsonize.opt) string metricsFifo;

	/***
	* Extra options to pass to the logger
	*
	* Mostly undocumented..
	***/
	@jsonize("options", Jsonize.opt) string[] options;
	
	/***
	* Option to show the level of individual events in the
	* log file.
	***/
	@jsonize("show_level", Jsonize.opt) bool showLevel;

	/***
	* Option to show the origin of where log events originate
	* from.
	***/
	@jsonize("show_log_origin", Jsonize.opt) bool showLogOrigin;

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
