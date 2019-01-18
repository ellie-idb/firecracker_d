module firecracker_d.models.vsock;
import jsonizer;
import firecracker_d.models.base_model;

struct Vsock {
	mixin JsonizeMe;
	mixin BaseModel;

	@jsonize("guest_cid", Jsonize.opt) long guestCid;

	@jsonize("id", Jsonize.yes) string id;

}
