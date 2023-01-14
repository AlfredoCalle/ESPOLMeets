module ESPOLMeets
  module Domain
    # A domain error.
    class DomainError < StandardError
      def initialize(msg)
        super
      end
    end
  end
end
