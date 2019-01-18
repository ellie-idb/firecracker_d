module firecracker_d.models.rate_limiter;
import jsonizer;
import firecracker_d.models.token_bucket;
import firecracker_d.models.base_model;

struct RateLimiter {
	mixin JsonizeMe;
	mixin BaseModel;

	/***
	* Token bucket with bytes as tokens
	***/
	@jsonize("bandwidth", Jsonize.opt) TokenBucket bandwidth;

	/***
	* Token bucket with operations as tokens
	***/
	@jsonize("ops", Jsonize.opt) TokenBucket ops;
}
