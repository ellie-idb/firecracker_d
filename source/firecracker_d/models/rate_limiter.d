module firecracker_d.models.rate_limiter;
import firecracker_d.models.token_bucket;
import firecracker_d.models.base_model;

struct RateLimiter {
	mixin BaseModel;

	/***
	* Token bucket with bytes as tokens
	***/
	@serializationKeys("bandwidth") TokenBucket bandwidth;

	/***
	* Token bucket with operations as tokens
	***/
	@serializationKeys("ops") TokenBucket ops;

}
