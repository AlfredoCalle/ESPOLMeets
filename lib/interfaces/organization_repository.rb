module ESPOLMeets
    module Interfaces
        class OrgRepository
            # Save an organization.
            def save(org:)
                raise NotImplementedError
            end
            # Get an Organization corresponding to the provided id.
            def get(org_id:)
                raise NotImplementedError
            end
        end
    end
end