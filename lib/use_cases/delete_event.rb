# frozen_string_literal: true

require_relative './use_case'

module ESPOLMeets
  module UseCase
    # Delete an event given its id.
    class DeleteEvent < UseCase
      def initialize(evt_id:, evt_repository:)
        @evt_id = evt_id
        @evt_repository = evt_repository
      end

      def execute
        return unless @evt_repository.get(@evt_id)

        @evt_repository.delete(@evt_id)
      end
    end
  end
end
