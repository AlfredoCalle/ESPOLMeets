require 'json'
require 'sinatra/base'

require_relative '../../lib/contracts/new_organization'
require_relative '../../lib/use_cases/get_organization'
require_relative '../../lib/use_cases/get_all_organizations'
require_relative '../../lib/use_cases/create_organization'
require_relative '../../lib/use_cases/delete_organization'
require_relative '../../lib/domain/domain_error'

module ESPOLMeets
    module Controller
        class OrganizationController < Sinatra::Base
            def initialize(org_repository:)
                super
                @org_repository = org_repository
            end

            delete '/organizations/:id' do
              org_id = params[:id]
              logger.info("Received request to delete organization with id '#{org_id}'")
      
              result = UseCase::DeleteOrganization.new(org_id:, org_repository: @org_repository).execute
      
              if result
                logger.info("Delete organization with id '#{org_id}'")
              else
                logger.info("Failed to delete organization with id '#{org_id}'")
              end
      
              204
            end

            get '/organizations', provides: 'application/json' do
              org_formatter = Formatters::HashOrganizationFormatter.new
              result = UseCase::GetAllOrganizations
                       .new(org_repository: @org_repository, org_formatter:)
                       .execute
              JSON.generate(result)
            end

            get '/organizations/:org_id', provides: 'application/json' do
                org_id = params[:org_id]
                logger.info("Received request to get organization with id '#{org_id}'")

                org_formatter = Formatters::JsonOrganizationFormatter.new
                
                result = UseCase::GetOrganization
                .new(org_id:, org_repository: @org_repository, org_formatter:)
                .execute

                if result
                    result
                else
                    logger.info("Failed to get organization with id '#{org_id}'")
                    400
                end
            end

            post '/organizations', provides: 'application/json' do
                body = request.body.read
                return 400 if body.empty?
        
                logger.info("Received request to create organization: #{body}")
                data = JSON.parse(body, { symbolize_names: true })
        
                new_org = Contracts::NewOrganization.new(
                  name: data[:name],
                  description: data[:description]
                )
        
                org_formatter = Formatters::JsonOrganizationFormatter.new
                result = UseCase::CreateOrganization
                         .new(new_org:, org_repository: @org_repository, org_formatter:)
                         .execute
        
                logger.info("Sending result: #{result}")
        
                if result.nil?
                  400
                else
                  [200, result]
                end
            rescue Domain::DomainError => e
              [400, JSON.dump({ error: e })]
            end

        end
    end
end