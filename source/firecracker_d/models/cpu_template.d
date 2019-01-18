module firecracker_d.models.cpu_template;
import jsonizer;

enum CPUTemplate : string {
	Uninitialized = "Uninitialized",
	C3 = "C3",
	T2 = "T2"
};
