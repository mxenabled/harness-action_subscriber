require "harness/action_subscriber/version"

require "harness"
require "active_support"

::ActiveSupport::Notifications.subscribe "message_acked.action_subscriber" do |*args|
  event = ::ActiveSupport::Notifications::Event.new(*args)
  event_name = event.payload[:queue].gsub(".", "-")
  ::Harness.increment "action_subscriber.messages_acked.#{event_name}"
  ::Harness.timing "action_subscriber.ack_duration.#{event_name}", event.duration
end

::ActiveSupport::Notifications.subscribe "message_nacked.action_subscriber" do |*args|
  event = ::ActiveSupport::Notifications::Event.new(*args)
  event_name = event.payload[:queue].gsub(".", "-")
  ::Harness.increment "action_subscriber.messages_nacked.#{event_name}"
  ::Harness.timing "action_subscriber.nack_duration.#{event_name}", event.duration
end

::ActiveSupport::Notifications.subscribe "message_rejected.action_subscriber" do |*args|
  event = ::ActiveSupport::Notifications::Event.new(*args)
  event_name = event.payload[:queue].gsub(".", "-")
  ::Harness.increment "action_subscriber.messages_rejected.#{event_name}"
  ::Harness.timing "action_subscriber.reject_duration.#{event_name}", event.duration
end

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
