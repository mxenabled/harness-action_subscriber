# Harness::ActionSubscriber

Report Statsd metrics about your ActionSubscribers via Harness

## Installation

1. Add this gem to the Gemfile
2. Create a rails initializer that sets up a Harness collector if you don't already have it configured.

```ruby
require 'harness'

Harness.config.collector = Statsd.new 'something.com'
```

## Contributing

1. Fork it ( https://github.com/mxenabled/harness-action_subscriber/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
