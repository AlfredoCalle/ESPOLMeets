require_relative '../../lib/interfaces/organization_repository'
require_relative '../../lib/domain/organization'

module ESPOLMeets
  module Persistence
    # SQLite implementation of an Organization repository.
    class SQLiteOrganizationRepository < Interfaces::OrganizationRepository
      def initialize(db)
        @db = db
        create_table
      end

      def create_table
        @db.execute <<-SQL
          create table if not exists organizations (
            org_id TEXT NOT NULL PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT
          );
        SQL
      end

      def org_from_row(row)
        Domain::Organization.new(
          org_id: row[0],
          name: row[1],
          description: row[2]
        )
      end

      def get(org_id)
        result = @db.get_first_row <<-SQL, org_id
          SELECT org_id, name, description
            FROM organizations
           WHERE org_id = ?
        SQL
        return unless result || result == []

        org_from_row(result)
      end

      def get_all
        result = @db.execute <<-SQL
          SELECT org_id, name, description
            FROM organizations
        SQL

        result.inject([]) do |organizations, row|
          organizations << org_from_row(row)
        end
      end

      def save(org)
        values = [
          org.org_id, org.name, org.description
        ]

        @db.execute <<-SQL, values
          INSERT INTO organizations (org_id, name, description)
          VALUES (?, ?, ?)
        SQL

        @db.changes == 1
      end

      def delete(org_id)
        @db.execute('DELETE FROM organizations WHERE org_id = ?', org_id)
        @db.changes == 1
      end
    end
  end
end
