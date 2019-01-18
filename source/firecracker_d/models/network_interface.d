module firecracker_d.models.network_interface;
import firecracker_d.models.base_model;
import firecracker_d.models.rate_limiter;

struct NetworkInterface {
	mixin JsonizeMe;
	mixin BaseModel;

	/***
	* Allow requests to the MicroVM Metadata Service
	***/
	@jsonize("allow_mmds_requests", Jsonize.opt) bool allowMMDSRequests;

	/***
	* The MAC address presented to the guest operating system for this device
	***/
	@jsonize("guest_mac", Jsonize.opt) string guestMAC;

	/***
	* The host's interface device name that we should use for networking
	*
	* Example: tap0, eth0, etc.
	***/
	@jsonize("host_dev_name", Jsonize.opt) string hostDevName;

	/***
	* Required: the ID we want to use for this network interface
	***/
	@jsonize("iface_id", Jsonize.yes) string ifaceID;

	/***
	* Rate limiters, meant to stop network traffic flooding from occuring.
	***/
	@jsonize("rx_rate_limiter", Jsonize.opt) RateLimiter rxRateLimiter;
	@jsonize("tx_rate_limiter", Jsonize.opt) RateLimiter txRateLimiter;

	/***
	* The current state of the interface
	***/
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
