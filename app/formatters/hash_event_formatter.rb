# frozen_string_literal: true

module ESPOLMeets
  module Formatters
    # Return the hash reprsentation of an event.
    class HashEventFormatter
      def format(evt)
        {
          evt_id: evt.evt_id,
          org_id: evt.org_id,
          name: evt.name,
          date: evt.event_time.date,
          time: evt.event_time.time,
          location: evt.location,
          description: evt.description,
          price: evt.price
        }
      end
    end
  end
end
