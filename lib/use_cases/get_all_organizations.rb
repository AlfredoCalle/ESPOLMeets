require_relative './use_case'

module ESPOLMeets
  module UseCase
    # Get all registered organizations
    class GetAllOrganizations < UseCase
      def initialize(org_repository:, org_formatter:)

        @org_repository = org_repository
        @org_formatter = org_formatter
      end

      def execute
        @org_repository
          .get_all
          .map { |evt| @org_formatter.format(evt) }
      end
    end
  end
end
