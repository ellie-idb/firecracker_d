module models.logger;
import jsonizer;

enum LoggerLevel : string {
		Error = "Error",
		Warning = "Warning",
		Info = "Info",
		Debug = "Debug"
}
import models.base_model;

struct Logger {
	mixin JsonizeMe;
	mixin BaseModel;

	

	@jsonize("level", Jsonize.opt) LoggerLevel level;

	@jsonize("log_fifo", Jsonize.opt) string logFifo;

	@jsonize("metrics_fifo", Jsonize.opt) string metricsFifo;

	@jsonize("options", Jsonize.yes) string[] options;

	@jsonize("show_level", Jsonize.opt) bool showLevel;

	@jsonize("show_log_origin", Jsonize.opt) bool showLogOrigin;
}
