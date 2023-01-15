# frozen_string_literal: true

require_relative '../../lib/interfaces/event_formatter'

module ESPOLMeets
  module Formatters
    # Format events as JSON
    class JsonEventFormatter < Interfaces::EventFormatter
      def format(evt)
        JSON.dump({
                    evt_id: evt.evt_id,
                    org_id: evt.org_id,
                    name: evt.name,
                    date: evt.event_time.date,
                    time: evt.event_time.time,
                    location: evt.location,
                    description: evt.description,
                    price: evt.price
                  })
      end
    end
  end
end
