module firecracker_d.models.network_interface;
import firecracker_d.models.base_model;
import firecracker_d.models.rate_limiter;

struct NetworkInterface {
	mixin JsonizeMe;
	mixin BaseModel;
	@jsonize("allow_mmds_requests", Jsonize.opt) bool allowMMDSRequests;

	@jsonize("guest_mac", Jsonize.opt) string guestMAC;

	@jsonize("host_dev_name", Jsonize.opt) string hostDevName;

	@jsonize("iface_id", Jsonize.yes) string ifaceID;

	@jsonize("rx_rate_limiter", Jsonize.opt) RateLimiter rxRateLimiter;

	@jsonize("tx_rate_limiter", Jsonize.opt) RateLimiter txRateLimiter;
	@jsonize("state", Jsonize.opt) string state;

	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/network-interfaces/" ~ ifaceID, this.toString);

		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}

	}

}
