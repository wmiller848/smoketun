use "net"

actor Main
  var _host: String = "127.0.0.1"
  var _service: String = "51137"

  new create(env:Env) =>
    var args = env.args
    if args.size() > 0 then
      for arg in args.values() do
        try
          var key_val = arg.split("=")
          let value = key_val.pop()
          let key = key_val.pop()

          match key
          | "target_ip" =>
            _host = value
            env.out.print("Target IP - " + _host)
          | "target_port" =>
            _service = value
            env.out.print("Target Port - " + _service)
          else
            env.out.print("Unknown parameter - " + key)
          end
        end
      end
      env.out.print(_host + ":" + _service)
      TCPListener(recover SmokeTCPListenNotify(env, 1) end, _host, _service, 0)
    else
      env.out.print("Error")
    end
