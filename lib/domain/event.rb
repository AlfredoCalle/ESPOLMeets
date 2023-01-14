# frozen_string_literal: true

require_relative './domain_error'

# Modulo de dominio.
module ESPOLMeets
  module Domain
    # Represent and event created by an Organization.
    class Event
      attr_reader :evt_id, :name, :org_id, :event_time, :location, :description, :price

      def initialize(evt_id:, name:, org_id:, event_time:, location:, description: '', price: nil)
        @evt_id = evt_id or raise(DomainError, 'Expected a non-nil event id')
        @name = name or raise(DomainError, 'Expected a non-nil event name')
        @org_id = org_id or raise(DomainError, 'Expected a non-nil organization id')
        @event_time = event_time or raise(DomainError, 'Expected a non-nil event time')
        @location = location or raise(DomainError, 'Expected a non-nil event location')
        @description = description
        @price = price
      end
    end
  end
end
