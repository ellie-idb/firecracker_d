module core.transport;
import std.stdio;
import requests;
import std.socket;
import std.format;
import core.time;
import core.stdc.errno;
import core.stdc.string;
import std.conv;

class UnixStream : NetworkStream {
    private {
        Duration timeout;
        Socket   s;
        bool     __isOpen;
        bool     __isConnected;
	string _facSocket;
        string   _bind;
    }
    void open(AddressFamily fa) {
	    __isOpen = true;
	    s = new Socket(fa, SocketType.STREAM);
    }
    @property Socket so() @safe pure {
        return s;
    }
    @property bool isOpen() @safe @nogc pure const {
        return s && __isOpen;
    }
    @property bool isConnected() @safe @nogc pure const {
        return s && __isOpen && __isConnected;
    }
    override void close() @trusted {
        debug(requests) tracef("Close socket");
        if ( isOpen ) {
            s.close();
            __isOpen = false;
            __isConnected = false;
        }
        s = null;
    }
    /***
    *  bind() just remember address. We will cal bind() at the time of connect as
    *  we can have several connection trials.
    ***/
    override void bind(string to) {
        _bind = to;
    }
    /***
    *  Make connection to remote site. Bind, handle connection error, try several addresses, etc
    ***/
    NetworkStream connect(string host, ushort port, Duration timeout = 10.seconds) {
        Address[] addresses;
        __isConnected = false;
        try {
            addresses ~= new UnixAddress(host);

        } catch (Exception e) {
            throw new ConnectError("Can't resolve name when connect to %s:%d: %s".format(host, port, e.msg));
        }
        foreach(a; addresses) {
            try {
                open(AddressFamily.UNIX);
                if ( _bind !is null ) {
                    auto ad = new UnixAddress(_bind);
		    writeln("bind to ", _bind);
                    s.bind(ad);
                }
                s.setOption(SocketOptionLevel.SOCKET, SocketOption.SNDTIMEO, timeout);
                s.connect(a);
                __isConnected = true;
                break;
            } catch (SocketException e) {
		writeln("Unable to connect..");
                s.close();
            }
        }
        if ( !__isConnected ) {
            throw new ConnectError("Can't connect to %s:%d".format(host, port));
        }
        return this;
    }

    override ptrdiff_t send(const(void)[] buff)
    in {assert(__isConnected);}
    body {
        auto rc = s.send(buff);
        if (rc < 0) {
            close();
            throw new NetworkException("sending data: %s".format(to!string(strerror(errno))));
        }
        return rc;
    }

    ptrdiff_t receive(void[] buff) {
        while (true) {
            auto r = s.receive(buff);
            if (r < 0) {
                auto e = errno;
                version(Windows) {
                    close();
                    if ( e == 0 ) {
                        throw new TimeoutException("Timeout receiving data");
                    }
                    throw new NetworkException("Unexpected error %s while receiving data".format(to!string(strerror(errno))));
                }
                version(Posix) {
                    if ( e == EINTR ) {
                        continue;
                    }
                    close();
                    if ( e == EAGAIN ) {
                        throw new TimeoutException("Timeout receiving data");
                    }
                    throw new NetworkException("Unexpected error %s while receiving data".format(to!string(strerror(errno))));
                }
            }
            else {
                buff.length = r;
            }
            return r;
        }
        assert(false);
    }

    @property void readTimeout(Duration timeout) @safe {
        if ( __isConnected )
        {
            s.setOption(SocketOptionLevel.SOCKET, SocketOption.RCVTIMEO, timeout);
        }
    }
    override NetworkStream accept() {
        assert(false, "Implement before use");
    }
    @property override void reuseAddr(bool yes){
        if (yes) {
            s.setOption(SocketOptionLevel.SOCKET, SocketOption.REUSEADDR, 1);
        }
        else {
            s.setOption(SocketOptionLevel.SOCKET, SocketOption.REUSEADDR, 0);
        }
    }
    override void bind(Address addr){
        s.bind(addr);
    }
    override void listen(int n) {
        s.listen(n);
    };

    void setFactorySocket(string socket) {
	    _facSocket = socket;
    }

    NetworkStream dg(string scheme, string host, ushort port) {
	    writefln("called with %s as host, %d as port", host, port);
	    UnixStream f = new UnixStream();
	    f.connect(_facSocket, 0);
	    return cast(NetworkStream)f;
    }

}
