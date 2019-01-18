module firecracker_d.models.token_bucket;
import jsonizer;
import firecracker_d.models.base_model;
/***
  This is a bucket that is mainly used for
  rate-limiting. After the one-time burst is used,
  the refill process begins, and after which, consumption is
  limited by the refill rate (which is derived from the bucket's	   size, as well as refill time)
***/
struct TokenBucket {
	mixin JsonizeMe;
	mixin BaseModel;
	
	/***
	* Total number of tokens this bucket can hold
	***/
	@jsonize("size", Jsonize.opt) long size;
	
	/***
	* The initial size of a token bucket
	***/
	@jsonize("one_time_burst", Jsonize.opt) long oneTimeBurst;

	/***
	* Time in MS for the bucket to refill 
	***/
	@jsonize("refill_time", Jsonize.opt) long refillTime;
}
