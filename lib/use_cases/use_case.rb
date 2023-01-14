# frozen_string_literal: true

module ESPOLMeets
  module UseCase
    # The base class for all application use cases.
    class UseCase
      # Execute this UseCase.
      def execute
        raise NotImplementedError
      end
    end
  end
end
