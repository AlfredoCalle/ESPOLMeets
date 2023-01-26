require_relative './use_case'
require_relative '../domain/organization'

module ESPOLMeets
    module UseCase
        class FollowOrganization < UseCase
            def initialize(org_id:, org_repository:)
                @org_id = org_id
                @org_repository = org_repository
            end

            def execute
                @org_repository.follow(@org_id)
            end
        end
    end
end