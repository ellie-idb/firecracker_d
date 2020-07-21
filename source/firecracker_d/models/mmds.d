module firecracker_d.models.mmds;
public import std.json;
// std.json is exported for ease of use
import firecracker_d.models.base_model;

/***
* MicroVM Data Store
* Note: requires `allow_mmds_requests == true` on the network interface to access.
***/

struct MMDS {
	/*
	* There's no good way to handle this, so 
	* we just expose the JSON object to the user.
	*/
	   
	JSONValue content;

	/***
    * Create a new MMDS via the Firecracker API
	* Throws: FirecrackerException
	***/
	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/mmds", content.toString);
		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}


	/***
	* Update the content of the MMDS via the Firecracker API
	* Throws: FirecrackerException
	***/
	bool patch(FirecrackerAPIClient cl) {
		Response r = cl.patch("/mmds", content.toString);
		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}


	/***
	* Get the MMDS via the Firecracker API
	* Throws: FirecrackerException
	***/
	this(FirecrackerAPIClient cl) {
		Response r = cl.get("/mmds");
		if(r.code == 200) {
			content = r.responseBody.toString.parseJSON;
		}
		else {
			throwFromResponse(r);
		}
	}
}

/***
* Defines the MMDS configuration.
***/
struct MMDSConfig {
    mixin BaseModel;

    /***
    * IPv4 address that the MMDS is reachable through (on the VM side)
    ***/
    @serializationKeys("ipv4_address") string ipv4Address;

	/***
    * Apply MMDS config via the Firecracker API
    * Pre-boot only
	* Throws: FirecrackerException
	***/
	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/mmds/config", this.stringify);
		if(r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}
}

   
    

