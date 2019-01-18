module models.token_bucket;
import jsonizer;
import models.base_model;

struct TokenBucket {
	mixin JsonizeMe;
	mixin BaseModel;

	@jsonize("size", Jsonize.opt) long size;

	@jsonize("one_time_burst", Jsonize.opt) long oneTimeBurst;

	@jsonize("refill_time", Jsonize.opt) long refillTime;
}
