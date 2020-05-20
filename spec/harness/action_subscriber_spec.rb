require "spec_helper"

describe ::Harness::ActionSubscriber do
  let(:collector) { ::Harness::NullCollector.new }
  let(:queue) { "abacus.amigo.user.created" }

  before do
    ::Harness.config.queue = ::Harness::SyncQueue.new
    ::Harness.config.collector = collector
  end

  it "has a version number" do
    expect(Harness::ActionSubscriber::VERSION).not_to be nil
  end

  describe "connection_blocked.action_subscriber" do
    before { ::ENV["SERVICE_NAME"] = "my_app" }
    after { ::ENV.delete("SERVICE_NAME") }

    it "increments the connection blocked count" do
      expect(collector).to receive(:increment).with("action_subscriber.my_app.connection.blocked.low_on_memory")
      ::ActiveSupport::Notifications.instrument("connection_blocked.action_subscriber", :reason => "low on memory")
    end
  end

  describe "connection_unblocked.action_subscriber" do
    it "increments the connection unblocked count" do
      expect(collector).to receive(:increment).with("action_subscriber.connection.unblocked")
      ::ActiveSupport::Notifications.instrument("connection_unblocked.action_subscriber")
    end
  end

  describe "message_acked.action_subscriber" do
    it "increments the message_acked counter" do
      expect(collector).to receive(:increment).with("action_subscriber.messages_acked.abacus-amigo-user-created")
      ::ActiveSupport::Notifications.instrument("message_acked.action_subscriber", :queue => queue)
    end

    it "records the ack_duration" do
      stat = ""
      duration = 0
      expect(collector).to receive(:timing) do |the_stat, the_duration|
        stat = the_stat
        duration = the_duration
      end
      ::ActiveSupport::Notifications.instrument("message_acked.action_subscriber", :queue => queue) do
        sleep 0.1
      end
      expect(stat).to eq("action_subscriber.ack_duration.abacus-amigo-user-created")
      expect(duration).to be >= 0.1
    end
  end

  describe "message_nacked.action_subscriber" do
    it "increments the message_nacked counter" do
      expect(collector).to receive(:increment).with("action_subscriber.messages_nacked.abacus-amigo-user-created")
      ::ActiveSupport::Notifications.instrument("message_nacked.action_subscriber", :queue => queue)
    end

    it "records the nack_duration" do
      stat = ""
      duration = 0
      expect(collector).to receive(:timing) do |the_stat, the_duration|
        stat = the_stat
        duration = the_duration
      end
      ::ActiveSupport::Notifications.instrument("message_nacked.action_subscriber", :queue => queue) do
        sleep 0.1
      end
      expect(stat).to eq("action_subscriber.nack_duration.abacus-amigo-user-created")
      expect(duration).to be >= 0.1
    end
  end

  describe "message_rejected.action_subscriber" do
    it "increments the message_rejected counter" do
      expect(collector).to receive(:increment).with("action_subscriber.messages_rejected.abacus-amigo-user-created")
      ::ActiveSupport::Notifications.instrument("message_rejected.action_subscriber", :queue => queue)
    end

    it "records the reject_duration" do
      stat = ""
      duration = 0
      expect(collector).to receive(:timing) do |the_stat, the_duration|
        stat = the_stat
        duration = the_duration
      end
      ::ActiveSupport::Notifications.instrument("message_rejected.action_subscriber", :queue => queue) do
        sleep 0.1
      end
      expect(stat).to eq("action_subscriber.reject_duration.abacus-amigo-user-created")
      expect(duration).to be >= 0.1
    end
  end
end
