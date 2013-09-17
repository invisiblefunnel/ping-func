## PingFunc

Periodically ping a list of URLs. A fun exploration of Ruby's malleability.

EM plumbing is inspired by [stevegraham/uptime](https://github.com/stevegraham/uptime). The rest is inspired by [jashkenas/underscore](https://github.com/jashkenas/underscore) and [readevalprintlove/ulithp](https://github.com/readevalprintlove/ulithp).

```console
$ bundle
$ cp sample.env .env
$ gem install foreman
$ foreman start
```

### Running on Heroku

```console
$ git clone https://github.com/invisiblefunnel/ping-func.git
$ heroku create <app name>
$ heroku config:set PING_INTERVAL=3600 PING_URLS='http://google.com,http://example.com'
$ git push heroku master
```
