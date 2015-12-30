require "harness/action_subscriber/version"

::ActiveSupport::Notifications.subscribe "popped_event.action_subscriber" do |*args|
  event = ::ActiveSupport::Notifications::Event.new(*args)
  event_name = event.payload[:queue].gsub '.', '-'
  ::Harness.increment "action_subscriber.popped_event.#{event_name}"
  ::Harness.gauge "action_subscriber.popped_event_bytes.#{event_name}", event.payload[:payload_size]
end

::ActiveSupport::Notifications.subscribe "received_event.action_subscriber" do |*args|
  event = ::ActiveSupport::Notifications::Event.new(*args)
  event_name = event.payload[:queue].gsub '.', '-'
  ::Harness.increment "action_subscriber.received_event.#{event_name}"
  ::Harness.gauge "action_subscriber.received_event_bytes.#{event_name}", event.payload[:payload_size]
end

::ActiveSupport::Notifications.subscribe "process_event.action_subscriber" do |*args|
  event = ::ActiveSupport::Notifications::Event.new(*args)
  event_name = event.payload[:queue].gsub '.', '-'
  ::Harness.timing "action_subscriber.process_event.#{event_name}", event.duration
end
