module firecracker_d.models.mmds;
// Expose std.json so you don't have to deal with importing it
public import std.json;
import firecracker_d.models.base_model;

/***
  MicroVM Data Store

Note: requires `allow_mmds_requests == true` on the network interface to
access.
***/

struct MMDS {
	/*
	* There's no good way to handle this, so 
	* we just expose the JSON object to the user.
	*/
	   
	JSONValue content;


	/***
	   Create a new MMDS via the Firecracker API

	   Throws a FirecrackerException if failed.
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
	  Update the content of the MMDS via the Firecracker API

	  Throws a FirecrackerException if failed.
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
	  Get the MMDS via the Firecracker API

	  Throws a FirecrackerException if failed.
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


