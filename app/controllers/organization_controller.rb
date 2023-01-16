require 'json'
require 'sinatra/base'

require_relative '../../lib/contracts/new_organization'
require_relative '../../lib/use_cases/get_organization'
require_relative '../../lib/use_cases/create_organization'
require_relative '../../lib/domain/domain_error'

module ESPOLMeets
    module Controller
        class OrganizationController < Sinatra::Base
            def initialize(org_repository:)
                super
                @org_repository = org_repository
            end

            get '/organizations/:org_id' do
                org_id = params[:org_id]
                logger.info("Received request to get organization with id '#{org_id}'")
                

                # json = '["foo", 1, 1.0, 2.0e2, true, false, null]'
                objeto = {
                    org_id: org_id,
                    name: "ESPOL",
                    description: "Universidad de la innovación."
                }

                json = '{"org_id": "#{org_id}", "name": "ESPOL", "description": "Universidad de la innovación."}'
                JSON.generate(objeto)


                # json = JSON.generate({org_id: org_id, name: 'ESPOL', description:})
                # JSON.parse("{'org_id': '#{org_id}', 'name': 'ESPOL'}, 'description': 'Universidad de la innovación.'")
                
                # result = UseCase::GetOrganization.new(org_id:, org_repository: @org_repository).execute

                # if result
                #     puts("Received request to get organization with id '#{org_id}'")
                #     JSON.generate(result)
                # else
                #     logger.info("Failed to get organization with id '#{org_id}'")
                # end
            end
        end
    end
end