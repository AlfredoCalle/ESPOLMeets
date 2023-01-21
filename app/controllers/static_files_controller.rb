module ESPOLMeets
  module Controller
    class StaticFilesController < Sinatra::Base
      set :public_folder, './public'

      get '/' do
        redirect to('index.html')
      end
    end
  end
end
