module ESPOLMeets
    module Contracts
      # A request to update an organization.
      class SameOrganization
        attr_reader :org_id, :name, :description
        def initialize(org_id:, name:, description: '')
            @org_id = org_id
            @name = name
            @description = description
        end
      end
    end
  end
  