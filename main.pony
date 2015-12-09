use "options"
use "net"

actor Main
  var _host: String = "127.0.0.1"
  var _service: String = "5050"

  new create(env:Env) =>
    var target_ip = ""
    var target_port = ""

    let options = Options(env) +
    ("ip", "i", StringArgument) +
    ("port", "p", StringArgument)

    for opt in options do
      match opt
      | ("ip", let arg: String) => target_ip = arg
      | ("port", let arg: String) => target_port = arg
      end
    end

    if target_ip == "" then
      env.out.print("./smoketun --ip=127.0.0.1 --port=5050")
      return
    end

    if target_port == "" then
      env.out.print("./smoketun --ip=127.0.0.1 --port=5050")
      return
    end

    env.out.print(target_ip + ":" + target_port)
    TCPListener(recover SmokeTCPListenNotify(env, 1) end, _host, _service, 0)
