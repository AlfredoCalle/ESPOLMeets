# frozen_string_literal: true

require_relative './use_case'

module ESPOLMeets
  module UseCase
    # Get all registered events
    class GetAllEvents < UseCase
      def initialize(evt_repository:, evt_formatter:)
        @evt_repository = evt_repository
        @evt_formatter = evt_formatter
      end

      def execute
        @evt_repository
          .get_all
          .map { |evt| @evt_formatter.format(evt) }
      end
    end
  end
end
