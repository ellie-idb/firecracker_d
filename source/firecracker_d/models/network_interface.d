module firecracker_d.models.network_interface;
import firecracker_d.models.base_model;
import firecracker_d.models.rate_limiter;

struct NetworkInterface {
	mixin JsonizeMe;
	mixin BaseModel;

	// Allow MMDS requests to the Microvm Metadata Service
	@jsonize("allow_mmds_requests", Jsonize.opt) bool allowMMDSRequests;

	// The MAC address presented to the guest operating system for
	// this device
	@jsonize("guest_mac", Jsonize.opt) string guestMAC;

	// The host's interface device name that
	// we should use
	@jsonize("host_dev_name", Jsonize.opt) string hostDevName;

	// ID of the interface
	@jsonize("iface_id", Jsonize.yes) string ifaceID;

	// Rate limiters, meant to stop network traffic flooding
	// from occuring.
	@jsonize("rx_rate_limiter", Jsonize.opt) RateLimiter rxRateLimiter;
	@jsonize("tx_rate_limiter", Jsonize.opt) RateLimiter txRateLimiter;
	// What is the interface's state currently?
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
