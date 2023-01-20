require 'random/formatter'

require_relative './use_case'
require_relative '../domain/organization'

module ESPOLMeets
    module UseCase
        class UpdateOrganization < UseCase
            def initialize(new_org:, org_repository:, org_formatter:)
                @new_org = new_org
                @org_repository = org_repository
                @org_formatter = org_formatter
            end

            def execute
                org_id = @new_org.org_id

                org = Domain::Organization.new(
                org_id:,
                name: @new_org.name,
                description: @new_org.description
                )

                return unless @org_repository.update(org)

                @org_formatter.format(org)
            end
        end
    end
end