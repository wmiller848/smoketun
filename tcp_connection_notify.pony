use "net"

class SmokeTCPConnectionNotify is TCPConnectionNotify
  let _env: Env

  new iso create(env: Env) =>
    _env = env

  fun ref connecting(conn: TCPConnection ref, count: U32) =>
    _env.out.print("connecting: " + count.string())

  fun ref connected(conn: TCPConnection ref) =>
    _env.out.print("connection connected")
    // try
    //   (let host, let service) = conn.remote_address().name()
    //   _env.out.print("connected to " + host + ":" + service)
    //   conn.set_nodelay(true)
    //   conn.set_keepalive(10)
    //   conn.write("client says hi")
    // end

  fun ref connect_failed(conn: TCPConnection ref) =>
    _env.out.print("connection failed")

  fun ref accepted(conn: TCPConnection ref) =>
    _env.out.print("connection accepted")
    // try
    //   (let host, let service) = conn.remote_address().name()
    //   _env.out.print("accepted from " + host + ":" + service)
    //   conn.write("server says hi")
    // end

  fun ref received(conn: TCPConnection ref, data: Array[U8] iso) =>
    _env.out.print("connection received")
    _env.out.print(consume data)
    conn.dispose()

  fun ref closed(conn: TCPConnection ref) =>
    _env.out.print("connection closed")