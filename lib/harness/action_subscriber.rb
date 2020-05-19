require "harness/action_subscriber/version"

require "harness"
require "active_support"

module Harness
  module ActionSubscriber
    UNBLOCKED_METRIC = ["action_subscriber", ENV["SERVICE_NAME"], "connection", "unblocked"].reject(&:nil?).join(".").freeze

    ::ActiveSupport::Notifications.subscribe "connection_blocked.action_subscriber" do |_, _, _, _, params|
      reason = params.fetch(:reason)
      blocked_metric = ["action_subscriber", ENV["SERVICE_NAME"], "connection", "blocked", reason.gsub(/\W/, "_")].
        reject(&:nil?).join(".")

      ::Harness.increment blocked_metric
    end

    ::ActiveSupport::Notifications.subscribe "connection_unblocked.action_subscriber" do
      ::Harness.increment UNBLOCKED_METRIC
    end

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
  end
end
