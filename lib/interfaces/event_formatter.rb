# frozen_string_literal: true

module ESPOLMeets
  module Interfaces
    # Represents an event formatter.
    class EventFormatter
      def format(evt)
        raise NotImplementedError
      end
    end
  end
end
