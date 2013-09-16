include PingFunc

LOG.('starting...')

CHAIN.(REQUIRE)
  .('bundler')
  .('eventmachine')
  .('em-http-request')
  .('em-synchrony')

CHAIN.(DEF)
  .(:INTERVAL, TO_I.
                 (FETCH.
                   (ENV, 'PING_INTERVAL', 20*60)))
  .(:URLS, MAP.
             ((SPLIT.
               (FETCH.
                 (ENV, 'PING_URLS', ''),
               ',')),
             STRIP))

CHAIN.(LOG)
  .('PING_INTERVAL = %s seconds' % INTERVAL)
  .('PING_URLS = %s' % JOIN.(URLS, ', '))

SYNCHRONY
  .(->{
    CHAIN.(PERIODICALLY)
      .(INTERVAL/10, ->{ LOG.('still alive...') })
      .(INTERVAL, ->{ EACH.(URLS, PING) }) })
