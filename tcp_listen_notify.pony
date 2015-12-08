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
    try
      (_host, _service) = listen.local_address().name()
      _env.out.print("listening on " + _host + ":" + _service)
    else
      _env.out.print("couldn't get local address")
      listen.close()
    end

  fun ref not_listening(listen: TCPListener ref) =>
    _env.out.print("not listening")
    listen.close()

  fun ref connected(listen: TCPListener ref): TCPConnectionNotify iso^ =>
    let server = SmokeTCPConnectionNotify(_env)
    server

  fun ref closed(listen: TCPListener ref) =>
    _env.out.print("closed")
