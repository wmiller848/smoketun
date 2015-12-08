use "net"

class SmokeTCPListenNotify is TCPListenNotify
  let _env : Env
  let uuid : U32
  var _count: U32 = 0
  var _host: String = ""
  var _service: String = ""

  new iso create(env':Env, uuid':U32) =>
    _env = env'
    uuid = uuid'

  fun ref listening(listen: TCPListener ref) =>
    """
    Called when the listener has been bound to an address.
    """
    try
      (_host, _service) = listen.local_address().name()
      _env.out.print("SmokeTCPListenNotify listening on " + _host + ":" + _service)
    else
      listen.close()
    end

  fun ref not_listening(listen: TCPListener ref) =>
    """
    Called if it wasn't possible to bind the listener to an address.
    """
    _env.out.print("SmokeTCPListenNotify not listening")
    listen.close()

  fun ref closed(listen: TCPListener ref) =>
    """
    Called when the listener is closed.
    """
    _env.out.print("SmokeTCPListenNotify closed")

  fun ref connected(listen: TCPListener ref): TCPConnectionNotify iso^ =>
    """
    Create a new TCPConnectionNotify to attach to a new TCPConnection for a
    newly established connection to the server.
    """
    let server = SmokeTCPConnectionNotify(_env)
    server
