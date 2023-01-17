require_relative './use_case'

module ESPOLMeets
    module UseCase
        class GetOrganization < UseCase
            def initialize(org_id:, org_repository:, org_formatter:)
                @org_id = org_id
                @org_repository = org_repository
                @org_formatter = org_formatter
            end

            def execute
                @org_formatter.format(@org_repository.get(@org_id))
            end
        end
    end
end