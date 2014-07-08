require "harness/action_subscriber/version"

::ActiveSupport::Notifications.subscribe "popped_event.action_subscriber" do |*args|
  event = ::ActiveSupport::Notifications::Event.new(*args)
  ::Harness.increment "action_subscriber.popped_event.#{event.payload[:queue]}"
  ::Harness.gauge "action_subscriber.popped_event_bytes.#{event.payload[:queue]}", event.payload[:payload_size]
end

::ActiveSupport::Notifications.subscribe "received_event.action_subscriber" do |*args|
  event = ::ActiveSupport::Notifications::Event.new(*args)
  ::Harness.increment "action_subscriber.received_event.#{event.payload[:queue]}"
  ::Harness.gauge "action_subscriber.received_event_bytes.#{event.payload[:queue]}", event.payload[:payload_size]
end

::ActiveSupport::Notifications.subscribe "process_event.action_subscriber" do |*args|
  event = ::ActiveSupport::Notifications::Event.new(*args)
  ::Harness.timing "action_subscriber.process_event.#{event.payload[:subscriber]}", event.duration
end
