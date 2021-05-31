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
    if SessionHelper.is_logged_in?(session)
      redirect to '/tweets'
    end
    erb :"sessions/signup"
    end

    post '/signup' do
      # binding.pry
      user = User.new(params)
      if !user.save
        redirect to '/signup'
      end
      user.save
      session[:user_id] = user.id
      redirect to '/tweets'
    end

    get '/login' do
      if SessionHelper.is_logged_in?(session)
        redirect to '/tweets'
      end

      erb :"sessions/login"
    end

    post '/login' do
      user = User.find_by(username: params[:username])
      session[:user_id] = user.id
      redirect to '/tweets'
    end

    get '/logout' do
      session.clear
      redirect to '/login'
    end

  #   get 'user/:slug' do
  #     @user = User.find_by_slug(params[:slug])
  #     erb :"users/show"
  # end


end
