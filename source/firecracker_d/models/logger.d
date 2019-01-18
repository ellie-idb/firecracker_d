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

	@jsonize("level", Jsonize.opt) LoggerLevel level;

	@jsonize("log_fifo", Jsonize.opt) string logFifo;

	@jsonize("metrics_fifo", Jsonize.opt) string metricsFifo;

	@jsonize("options", Jsonize.opt) string[] options;

	@jsonize("show_level", Jsonize.opt) bool showLevel;

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
