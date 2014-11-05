class ApplicationController < Sinatra::Base

  helpers AuthenticationHelper

  enable :sessions
  enable :method_override

  register Sinatra::ActiveRecordExtension

  set :database, {adapter: "postgresql", database: "glemur_games_db"}
  set :views, File.expand_path("../../views", __FILE__)
  set :public_folder, File.expand_path("../../public", __FILE__)

  get '/' do
    if current_user
      erb :'game_menu/index'
    else
      erb :index
    end
  end

  get '/scoreboard' do
    erb :'scoreboard/index'
  end

  get '/profile' do
    erb :'profile/index'
  end

  get '/games' do
    erb :'game_menu/index'
  end

end