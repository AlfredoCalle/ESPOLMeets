module ESPOLMeets
    module Interfaces
        class OrganizationRepository
            # Save an organization.
            def save(org:)
                raise NotImplementedError
            end
            # Get an Organization corresponding to the provided id.
            def get(org_id:)
                raise NotImplementedError
            end

            # Get all registered organizations.
            def get_all
                raise NotImplementedError
            end

            # Delete the organization corresponding to the provided event id.
            def delete(org_id:)
                raise NotImplementedError
            end
        end
    end
end