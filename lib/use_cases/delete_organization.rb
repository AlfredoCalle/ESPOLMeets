require_relative './use_case'

module ESPOLMeets
  module UseCase
    # Delete an organization given its id.
    class DeleteOrganization < UseCase
      def initialize(org_id:, org_repository:)
        @org_id = org_id
        @org_repository = org_repository
      end

      def execute
        return unless @org_repository.get(@org_id)

        @org_repository.delete(@org_id)
      end
    end
  end
end
