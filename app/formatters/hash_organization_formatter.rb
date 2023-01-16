module ESPOLMeets
  module Formatters
    class HashOrganizationFormatter
      def format(org)
        {
          org_id: org.evt_id,
          name: org.name,
          description: org.description
        }
      end
    end
  end
end
