module ESPOLMeets
    module Contracts
      # A request to create a new organization.
      class NewOrganization
        attr_reader :org_id, :name, :description
        def initialize(name:, description: '')
            @name = name
            @description = description
        end
      end
    end
  end
  