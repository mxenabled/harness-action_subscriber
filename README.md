# Harness::ActionSubscriber

Log ActionSubscriber via Harness

## Installation

1. Add this gem to the Gemfile
2. Create a rails initializer that sets up a Harness collector if you don't already have it configured.

```ruby
require 'buttress/statsd'
require 'harness'

config_file = ::Rails.root.join('config', 'statsd.yml')

if ::File.exists?(config_file) && ::Rails.env != 'test'
  ::Buttress::Statsd.initialize!(config_file)
end

::Harness.config.collector = ::Buttress.statsd
```

## Contributing

1. Fork it ( https://git.moneydesktop.com/dev/harness-action_subscriber/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
