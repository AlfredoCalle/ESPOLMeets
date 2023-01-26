module ESPOLMeets
  module Formatters
    class HashOrganizationFormatter
      def format(org)
        {
          org_id: org.org_id,
          name: org.name,
          description: org.description,
          is_followed: org.is_followed
        }
      end
    end
  end
end
