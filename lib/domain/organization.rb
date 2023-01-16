require_relative './domain_error'

module ESPOLMeets
    module Domain
        class Organization
            attr_reader :org_id, :name, :description
            def initialize(org_id:, name:, description: '')
                @org_id = org_id or raise(DomainError, 'Expected a non-nil organization id')
                @name = name or raise(DomainError, 'Expected a non-nil name')
                @description = description
            end
        end
    end
end