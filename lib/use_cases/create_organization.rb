require 'random/formatter'

require_relative './use_case'

# Aun falta de implementar

module ESPOLMeets
    module UseCase
        class CreateOrganization < UseCase
            def initialize(new_org:, org_repository:)
                @new_org = new_org
                @org_repository = org_repository
            end

            def execute
                return unless @org_repository.save(@new_org)
            end
        end
    end
end