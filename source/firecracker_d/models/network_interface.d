module firecracker_d.models.network_interface;
import firecracker_d.models.base_model;
import firecracker_d.models.rate_limiter;

struct NetworkInterface {
    mixin BaseModel;

	/***
	* Allow requests to the MicroVM Metadata Service
	***/
	@serializationKeys("allow_mmds_requests") bool allowMMDSRequests;

	/***
	* The MAC address presented to the guest operating system for this device
	***/
	@serializationKeys("guest_mac") string guestMAC;

	/***
	* The host's interface device name that we should use for networking
	*
	* Example: tap0, eth0, etc.
	***/
    @serializationRequired 
	@serializationKeys("host_dev_name") string hostDevName;

	/***
	* Required: the Firecracker ID we want to use for this network interface
	***/
    @serializationRequired
	@serializationKeys("iface_id") string ifaceID;

	/***
	* Recieve rate limiter, meant to stop network traffic flooding from occuring.
	***/
	@serializationKeys("rx_rate_limiter") RateLimiter rxRateLimiter;

	/***
	* Transmit rate limiter, meant to stop network traffic flooding from occuring.
	***/
	@serializationKeys("tx_rate_limiter") RateLimiter txRateLimiter;

	/***
	  Create the network interface via the Firecracker API

	  Throws a FirecrackerException if failed.
	***/

	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/network-interfaces/" ~ ifaceID, this.stringify);

		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}

	}
}
