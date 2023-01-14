# frozen_string_literal: true

require 'random/formatter'

require_relative './use_case'
require_relative '../domain/event'
require_relative '../domain/event_time'

module ESPOLMeets
  module UseCase
    # Use case for creating a new event.
    class CreateEvent < UseCase
      def initialize(new_evt:, evt_repository:)
        @new_evt = new_evt
        @evt_repository = evt_repository
      end

      def execute
        evt_id = Random.new.uuid

        evt = Domain::Event.new(
          evt_id:,
          name: @new_evt.name,
          org_id: @new_evt.org_id,
          event_time: Domain::EventTime.new(date: @new_evt.date, time: @new_evt.time),
          location: @new_evt.location,
          description: @new_evt.description,
          price: @new_evt.price
        )

        @evt_repository.save(evt)
      end
    end
  end
end
