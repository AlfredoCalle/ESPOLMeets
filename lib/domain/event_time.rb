# frozen_string_literal: true

require 'date'
require 'time'

module ESPOLMeets
  module Domain
    # Represents an event's date and time.
    class EventTime
      attr_reader :date, :time

      def initialize(date:, time:)
        @date = Date.parse(date)
        @time = Time.parse(time)
      end
    end
  end
end
