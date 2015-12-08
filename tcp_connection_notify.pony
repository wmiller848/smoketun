use "net"

class SmokeTCPConnectionNotify is TCPConnectionNotify
  let _env: Env

  new iso create(env: Env) =>
    _env = env

  fun ref accepted(conn: TCPConnection ref) =>
    """
    Called when a TCPConnection is accepted by a TCPListener.
    """
    try
      let remote = conn.remote_address()
      (let ip, let port) = remote.name()
      _env.out.print("SmokeTCPConnectionNotify connection accepted from: " + ip)
    else
      conn.dispose()
    end


  fun ref connecting(conn: TCPConnection ref, count: U32) =>
    """
    Called if name resolution succeeded for a TCPConnection and we are now
    waiting for a connection to the server to succeed. The count is the number
    of connections we're trying. The notifier will be informed each time the
    count changes, until a connection is made or connect_failed() is called.
    """
    _env.out.print("SmokeTCPConnectionNotify connecting: " + count.string())

  fun ref connected(conn: TCPConnection ref) =>
    """
    Called when we have successfully connected to the server.
    """
    _env.out.print("SmokeTCPConnectionNotify connection connected")

  fun ref connect_failed(conn: TCPConnection ref) =>
    """
    Called when we have failed to connect to all possible addresses for the
    server. At this point, the connection will never be established.
    """
    _env.out.print("SmokeTCPConnectionNotify connection failed")

  fun ref auth_failed(conn: TCPConnection ref) =>
    """
    A raw TCPConnection has no authentication mechanism. However, when
    protocols are wrapped in other protocols, this can be used to report an
    authentication failure in a lower level protocol (eg. SSL).
    """
    _env.out.print("SmokeTCPConnectionNotify connection authorization failed")

  fun ref sent(conn: TCPConnection ref, data: ByteSeq): ByteSeq =>
    """
    Called when data is sent on the connection. This gives the notifier an
    opportunity to modify sent data before it is written. The notifier can
    raise an error if the data is swallowed entirely.
    """
    data

  fun ref received(conn: TCPConnection ref, data: Array[U8] iso) =>
    """
    Called when new data is received on the connection.
    """
    _env.out.print("SmokeTCPConnectionNotify data received")
    _env.out.print(consume data)
    conn.dispose()

  fun ref closed(conn: TCPConnection ref) =>
    """
    Called when the connection is closed.
    """
    _env.out.print("SmokeTCPConnectionNotify connection closed")

  // try
  //   (let host, let service) = conn.remote_address().name()
  //   _env.out.print("connected to " + host + ":" + service)
  //   conn.set_nodelay(true)
  //   conn.set_keepalive(10)
  //   conn.write("client says hi")
  // end

  // try
  //   (let host, let service) = conn.remote_address().name()
  //   _env.out.print("accepted from " + host + ":" + service)
  //   conn.write("server says hi")
  // end
