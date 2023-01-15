# frozen_string_literal: true

require 'sqlite3'

require_relative './controllers/event_controller'
require_relative './persistence/sqlite_event_repository'
require_relative './formatters/json_event_formatter'
require_relative './formatters/hash_event_formatter'

module ESPOLMeets
  # Main application.
  class App
    def initialize
      db = SQLite3::Database.new 'espol_meets.db'

      evt_repository = Persistence::SQLiteEventRepository.new(db)

      @app = Rack::Builder.app do
        # TODO: Figure out how to use the logger.
        use Rack::CommonLogger
        map '/api/v1' do
          run Controller::EventController.new(evt_repository:)
        end
      end
    end

    def call(env)
      @app.call(env)
    end
  end
end
