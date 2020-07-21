module firecracker_d.models.vsock;
import firecracker_d.models.base_model;
/***
    Defines a vsock device, backed by a set of Unix Domain Sockets, on the host side.
    For host-initiated connections, Firecracker will be listening on the Unix socket
    identified by the path `uds_path`. Firecracker will create this socket, bind and
    listen on it. Host-initiated connections will be performed by connection to this
    socket and issuing a connection forwarding request to the desired guest-side vsock
    port (i.e. `CONNECT 52\n`, to connect to port 52).
    For guest-initiated connections, Firecracker will expect host software to be
    bound and listening on Unix sockets at `uds_path_<PORT>`.
    E.g. "/path/to/host_vsock.sock_52" for port number 52.
***/
struct Vsock {
	mixin BaseModel;

	/***
	* The guest's Context Identifier
	***/
    @serializationRequired
	@serializationKeys("guest_cid") long guestCid;

	/***
	* VSock ID
	***/
    @serializationRequired
	@serializationKeys("vsock_id") string id;

    /***
    * Path to UNIX domain socket, used to proxy vsock connections.
    ***/
    @serializationRequired
    @serializationKeys("uds_path") string path;

	/***
	* Create the Vsock via the Firecracker API. 
	* Throws: FirecrackerException on error.
	***/
	bool put(FirecrackerAPIClient cl) {
		Response r = cl.put("/vsocks/" ~ id, this.stringify);

		if(r.code == 201 || r.code == 204) {
			return true;
		}
		else {
			throwFromResponse(r);
			return false;
		}
	}

}
