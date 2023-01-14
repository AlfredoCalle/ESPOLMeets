module ESPOLMeets
  module Interfaces
    # An abstract interface to persist events to some media.
    class EventRepository
      # Save an event.
      def save(evt:)
        raise NotImplementedError
      end

      # Get an Event corresponding to the provided id.
      def get(evt_id:)
        raise NotImplementedError
      end

      # Replace the event identified by the provided id with
      # the provided event.
      def update(evt_id:, evt:)
        raise NotImplementedError
      end

      # Delete the event corresponding to the provided event id.
      def delete(evt_id:)
        raise NotImplementedError
      end
    end
  end
end
