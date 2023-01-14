# frozen_string_literal: true

# Modulo de dominio.
module ESPOLMeets
  module Domain
    # Represent and event created by an Organization.
    class Event
      attr_reader :evt_id, :name, :org_id, :event_time, :location, :description, :price

      def initialize(evt_id:, name:, org_id:, event_time:, location:, description: '', price: nil)
        @evt_id = evt_id
        @name = name
        @org_id = org_id
        @event_time = event_time
        @location = location
        @description = description
        @price = price
      end
    end
  end
end
