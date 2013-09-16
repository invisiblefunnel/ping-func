module PingFunc
  DEF = ->(name, func){ self.const_set(name, func) }
  CHAIN = ->(func){ ->(*args){ func.(*args); CHAIN.(func) } }
  CHAIN.(DEF)
    .(:REQUIRE, ->(lib){ require(lib) })
    .(:IDENTITY, ->(value){ value })
    .(:FETCH, ->(map, key, default = nil){ map[key] || default })
    .(:STRIP, ->(val){ val.strip })
    .(:SPLIT, ->(str, separator = ' '){ str.split(separator) })
    .(:JOIN, ->(list, separator = ' '){ list.join(separator) })
    .(:MAX, ->(*list){ list.max })
    .(:TO_I, ->(val){ val.to_i })
    .(:EACH, ->(list, func){ list.each(&func) })
    .(:MAP, ->(list, func){ res = []; EACH.(list, ->(val){ res << func.(val) }); res })
    .(:PRINT, ->(value, sync = true) { $stdout.sync = sync; puts(value) })
    .(:FORMATTED_LOG, ->(formatter = IDENTITY){ ->(value){ PRINT.(formatter.(value), true) } })
    .(:FORMATTER, ->(value){ "%s: %s" % [self, value] })
    .(:LOG, FORMATTED_LOG.(FORMATTER))
    .(:ARGLOG, ->(func){ ->(*args){ LOG.(args); func.(*args) } })
    .(:PERIODICALLY, ->(interval, func){ EM.add_periodic_timer(interval, &func) })
    .(:SYNCHRONY, ->(func){ EM.synchrony(&func) })
    .(:REQUEST, ->(url){ EM::HttpRequest.new(url).get })
    .(:PING, ARGLOG.(REQUEST))
end
