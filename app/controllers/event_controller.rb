# frozen_string_literal: true

require 'json'

require 'sinatra/base'

require_relative '../../lib/contracts/new_event'
require_relative '../../lib/use_cases/create_event'

module ESPOLMeets
  module Controller
    class EventController < Sinatra::Base
      def initialize(evt_repository:)
        super
        @evt_repository = evt_repository
      end

      post '/events' do
        body = request.body.read
        return 400 if body.empty?

        logger.info("Received request to create event: #{body}")
        data = JSON.parse(body,  {symbolize_names: true})

        new_evt = Contracts::NewEvent.new(
          name: data[:name],
          org_id: data[:org_id],
          date: data[:date],
          time: data[:time],
          location: data[:location],
          description: data[:description],
          price: data[:price]
        )

        result = UseCase::CreateEvent
          .new(new_evt:, evt_repository:  @evt_repository)
          .execute

        if result.nil?
          400
        else
          [200, result]
        end
      end
    end
  end
end
