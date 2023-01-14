# frozen_string_literal: true

module ESPOLMeets
  module Domain
    # Represents an event's date and time.
    class EventTime
      attr_reader :date, :time

      def initialize(date:, time:)
        @date = date
        @time = time
      end
    end
  end
end
