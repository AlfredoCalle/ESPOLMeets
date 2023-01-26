# frozen_string_literal: true

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
        @db.execute('drop table if exists organizations;')

        @db.execute <<-SQL
          create table if not exists organizations (
            org_id TEXT NOT NULL PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT,
            is_followed INTEGER NOT NULL DEFAULT 0
          );
        SQL

        @db.execute <<-SQL
          insert into organizations (org_id, name, description)
          values ('a197a335-7e39-4315-b08f-81128caa6e10', 'Kokoa', 'Club de Software Libre'),
                 ('1234', 'Club de Lenguajes', 'Hablamos de lenguajes wooooo');
        SQL
      end

      def org_from_row(row)
        Domain::Organization.new(
          org_id: row[0],
          name: row[1],
          description: row[2],
          is_followed: row[3]
        )
      end

      def get(org_id)
        result = @db.get_first_row <<-SQL, org_id
          SELECT org_id, name, description, is_followed
            FROM organizations
           WHERE org_id = ?
        SQL
        return unless result || result == []

        org_from_row(result)
      end

      def get_all
        result = @db.execute <<-SQL
          SELECT org_id, name, description, is_followed
            FROM organizations
        SQL

        result.inject([]) do |organizations, row|
          organizations << org_from_row(row)
        end
      end

      def get_all_follow
        result = @db.execute <<-SQL
          SELECT org_id, name, description, is_followed
          FROM organizations
          WHERE is_followed = 1
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

      def follow(org_id)
        @db.execute <<-SQL, org_id
          UPDATE organizations
          SET is_followed = 1
          WHERE org_id = ?
        SQL

        @db.changes == 1
      end

      def update(org)
        org_id = org.org_id
        organization = get(org_id)

        values = [
          org.name || organization.name,
          org.description || organization.description,
          org_id
        ]

        @db.execute <<-SQL, values
          UPDATE organizations
          SET name = ?, description = ?
          WHERE org_id = ?
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
