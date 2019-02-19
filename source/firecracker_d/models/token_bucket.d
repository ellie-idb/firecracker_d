module firecracker_d.models.token_bucket;
import firecracker_d.models.base_model;
/***
  This is a bucket that is mainly used for
  rate-limiting. After the one-time burst is used,
  the refill process begins, and after which, consumption is
  limited by the refill rate (which is derived from the bucket's	   size, as well as refill time)
***/
struct TokenBucket {
	mixin BaseModel;
	/***
	* Total number of tokens this bucket can hold
	***/
	@serializationKeys("size") long size;
	
	/***
	* The initial size of a token bucket
	***/
	@serializationKeys("one_time_burst") long oneTimeBurst;

	/***
	* Time in MS for the bucket to refill 
	***/
	@serializationKeys("refill_time") long refillTime;

}
