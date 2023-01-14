# frozen_string_literal: true

module ESPOLMeets
  module Contracts
    # A request to create a new event.
    class NewEvent
      attr_reader :name, :org_id, :date, :time, :location, :description, :price

      def initialize(name:, org_id:, date:, time:, location:, description: '', price: nil)
        @name = name
        @org_id = org_id
        @date = date
        @time = time
        @location = location
        @description = description
        @price = price
      end
    end
  end
end
