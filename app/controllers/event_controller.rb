# frozen_string_literal: true

require 'json'

require 'sinatra/base'

require_relative '../../lib/contracts/new_event'
require_relative '../../lib/use_cases/create_event'
require_relative '../../lib/use_cases/delete_event'
require_relative '../../lib/use_cases/get_all_events'
require_relative '../../lib/domain/domain_error'
require_relative '../formatters/hash_event_formatter'

module ESPOLMeets
  module Controller
    # Controller for events.
    class EventController < Sinatra::Base
      configure { enable :logging }

      def initialize(evt_repository:)
        super
        @evt_repository = evt_repository
      end

      delete '/:id' do
        evt_id = params[:id]
        logger.info("Received request to delete event with id '#{evt_id}'")

        result = UseCase::DeleteEvent.new(evt_id:, evt_repository: @evt_repository).execute

        if result
          logger.info("Delete event with id '#{evt_id}'")
        else
          logger.info("Failed to delete event with id '#{evt_id}'")
          400
        end

        204
      end

      get '/', provides: 'application/json' do
        evt_formatter = Formatters::HashEventFormatter.new
        result = UseCase::GetAllEvents
                 .new(evt_repository: @evt_repository, evt_formatter:)
                 .execute
        JSON.generate(result)
      end

      post '/', provides: 'application/json' do
        body = request.body.read
        return 400 if body.empty?

        logger.info("Received request to create event: #{body}")
        data = JSON.parse(body, { symbolize_names: true })

        new_evt = Contracts::NewEvent.new(
          name: data[:name],
          org_id: data[:org_id],
          date: data[:date],
          time: data[:time],
          location: data[:location],
          description: data[:description],
          price: data[:price]
        )

        evt_formatter = Formatters::JsonEventFormatter.new
        result = UseCase::CreateEvent
                 .new(new_evt:, evt_repository: @evt_repository, evt_formatter:)
                 .execute

        logger.info("Sending result: #{result}")

        if result.nil?
          400
        else
          [200, result]
        end
      rescue Domain::DomainError => e
        [400, JSON.dump({ error: e })]
      end
    end
  end
end
