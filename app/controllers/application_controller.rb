require './config/environment'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "session_encryption"
  end

  get '/' do
    
    erb :"index"
  end

  get '/signup' do
    
    erb :"sessions/signup"
    end

    post '/signup' do
      user = User.new(params)
      if !user.save
        redirect to '/signup'
      end
      user.save
      session[:user_id] = user.id
      redirect to '/tweets'
    end


end
