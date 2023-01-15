# frozen_string_literal: true

require_relative '../../lib/interfaces/event_repository'
require_relative '../../lib/domain/event'
require_relative '../../lib/domain/event_time'

module ESPOLMeets
  module Persistence
    # SQLite implementation of an Event repository.
    class SQLiteEventRepository < Interfaces::EventRepository
      def initialize(db)
        @db = db
        create_table
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

      def evt_from_row(row)
        Domain::Event.new(
          evt_id: row[0],
          name: row[1],
          org_id: row[2],
          event_time: Domain::EventTime.new(date: row[3], time: row[4]),
          location: row[5],
          description: row[6],
          price: row[7]
        )
      end

      def get(evt_id)
        result = @db.get_first_row <<-SQL, evt_id
          SELECT evt_id, name, org_id, date, time, location, description, price
            FROM events
           WHERE evt_id = ?
        SQL
        return unless result || result == []

        evt_from_row(result)
      end

      def get_all
        result = @db.execute <<-SQL
          SELECT evt_id, name, org_id, date, time, location, description, price
            FROM events
        SQL

        result.inject([]) do |events, row|
          events << evt_from_row(row)
        end
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

        @db.changes == 1
      end

      def delete(evt_id)
        @db.execute('DELETE FROM events WHERE evt_id = ?', evt_id)
        @db.changes == 1
      end
    end
  end
end
