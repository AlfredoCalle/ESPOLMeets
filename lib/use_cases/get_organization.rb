require_relative './use_case'

module ESPOLMeets
    module UseCase
        class GetOrganization < UseCase
            def initialize(org_id:, org_repository:)
                @org_id = org_id
                @org_repository = org_repository
            end

            def execute
                return unless @org_repository.get(@org_id)
            end
        end
    end
end