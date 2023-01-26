require_relative './domain_error'

module ESPOLMeets
    module Domain
        class Organization
            attr_reader :org_id, :name, :description, :is_followed
            def initialize(org_id:, name:, description: '', is_followed: 0)
                @org_id = org_id or raise(DomainError, 'Expected a non-nil organization id')
                @name = name or raise(DomainError, 'Expected a non-nil name')
                @description = description
                @is_followed = is_followed
            end
        end
    end
end