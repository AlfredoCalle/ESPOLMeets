require 'random/formatter'

require_relative './use_case'
require_relative '../domain/organization'

# Aun falta de implementar

module ESPOLMeets
    module UseCase
        class CreateOrganization < UseCase
            def initialize(new_org:, org_repository:, org_formatter:)
                @new_org = new_org
                @org_repository = org_repository
                @org_formatter = org_formatter
            end

            def execute
                org_id = Random.new.uuid

                org = Domain::Organization.new(
                org_id:,
                name: @new_org.name,
                description: @new_org.description
                )

                return unless @org_repository.save(org)

                @org_formatter.format(org)
            end
        end
    end
end