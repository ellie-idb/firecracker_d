module models.rate_limiter;
import jsonizer;
import models.token_bucket;
import models.base_model;

struct RateLimiter {
	mixin JsonizeMe;
	mixin BaseModel;

	@jsonize("bandwidth", Jsonize.opt) TokenBucket bandwidth;

	@jsonize("ops", Jsonize.opt) TokenBucket ops;
}
