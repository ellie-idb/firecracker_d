module firecracker_d.models.token_bucket;
import jsonizer;
import firecracker_d.models.base_model;

struct TokenBucket {
	mixin JsonizeMe;
	mixin BaseModel;

	@jsonize("size", Jsonize.opt) long size;

	@jsonize("one_time_burst", Jsonize.opt) long oneTimeBurst;

	@jsonize("refill_time", Jsonize.opt) long refillTime;
}
