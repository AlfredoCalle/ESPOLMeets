require_relative '../../lib/interfaces/organization_formatter'

module ESPOLMeets
  module Formatters
    class JsonOrganizationFormatter < Interfaces::OrganizationFormatter
      def format(org)
        JSON.dump({
                    org_id: org.org_id,
                    name: org.name,
                    description: org.description
                  })
      end
    end
  end
end
