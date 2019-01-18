module firecracker_d.models.logger;
import jsonizer;

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

	// How verbose should the logger be?
	@jsonize("level", Jsonize.opt) LoggerLevel level;

	// Where should the log output go? 
	// Can be a file or an actual named pipe
	@jsonize("log_fifo", Jsonize.opt) string logFifo;

	// Where should the metrics output go?
	// Can be a file or an actual named pipe
	@jsonize("metrics_fifo", Jsonize.opt) string metricsFifo;

	// What are some extra options we should pass 
	// to the logger? 
	@jsonize("options", Jsonize.opt) string[] options;
	
	// Should we show the log level of events
	// in the log file?
	@jsonize("show_level", Jsonize.opt) bool showLevel;

	// Should we show where events come from 
	// in the log file?
	@jsonize("show_log_origin", Jsonize.opt) bool showLogOrigin;

	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/logger", this.toString);
		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}
}
