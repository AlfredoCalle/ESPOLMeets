require_relative './controllers/event_controller'

module ESPOLMeets
  class App
    def initialize
      @app = Rack::Builder.app do
        # TODO: Figure out how to use the logger.
        use Rack::CommonLogger
        map "/api/v1" do
          run Controller::EventController.new(evt_repository: nil)
        end
      end
    end

    def call(env)
      @app.call(env)
    end
  end
end

