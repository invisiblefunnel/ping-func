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
             (STRIP,
             (SPLIT.
               (FETCH.
                 (ENV, 'PING_URLS', ''),
               ','))))

CHAIN.(LOG)
  .('PING_INTERVAL = %s seconds' % INTERVAL)
  .('PING_URLS = %s' % JOIN.(URLS, ', '))

SYNCHRONY
  .(->{
    CHAIN.(PERIODICALLY)
      .(->{ LOG.('still alive...') }, INTERVAL/10)
      .(->{ EACH.(PING, URLS) }, INTERVAL) })
