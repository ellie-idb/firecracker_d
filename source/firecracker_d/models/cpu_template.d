module firecracker_d.models.cpu_template;

/*** 
*   The CPU templates are flags that will disable 
*   certain features on the MicroVM, primarily 
*   used by AWS internally.
***/

enum CPUTemplate : string {
	Uninitialized = "Uninitialized",
	C3 = "C3",
	T2 = "T2"
};
