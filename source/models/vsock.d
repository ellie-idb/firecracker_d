module models.vsock;
import jsonizer;
import models.base_model;

struct Vsock {
	mixin JsonizeMe;
	mixin BaseModel;

	@jsonize("guest_cid", Jsonize.opt) long guestCid;

	@jsonize("id", Jsonize.yes) string id;

}
