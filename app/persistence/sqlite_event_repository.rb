# frozen_string_literal: true

require_relative '../../lib/interfaces/event_repository'

module ESPOLMeets
  module Persistence
    # SQLite implementation of an Event repository.
    class SQLiteEventRepository < Interfaces::EventRepository
      def initialize(db)
        @db = db
      end

      def create_table
        @db.execute <<-SQL
          create table if not exists events (
            evt_id TEXT NOT NULL PRIMARY KEY,
            name TEXT NOT NULL,
            org_id TEXT NOT NULL,
            date TEXT NOT NULL,
            time TEXT NOT NULL,
            location TEXT NOT NULL,
            description TEXT,
            price NUMERIC
          );
        SQL
      end

      def save(evt)
        values = [
          evt.evt_id, evt.name, evt.org_id,
          evt.event_time.date.to_s, evt.event_time.time.to_s,
          evt.location, evt.description, evt.price
        ]
        @db.execute <<-SQL, values
          INSERT INTO events (evt_id, name, org_id, date, time, location, description, price)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        SQL
      end
    end
  end
end
