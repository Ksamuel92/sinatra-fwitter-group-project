class TweetsController < ApplicationController

get '/tweets' do
    if !SessionHelper.is_logged_in?(session)
        redirect to '/login'
    end
    @user = User.find_by_id(session[:user_id])
    @tweets = Tweet.all
    erb :"tweets/index"
end

get '/tweets/new' do
    if !SessionHelper.is_logged_in?(session)
        redirect to '/login'
    end

    erb :"tweets/new"
end

post '/tweets' do
    #  binding.pry
    tweet = Tweet.new(content: params[:content])
    tweet.user_id = session[:user_id]
    if !tweet.save
        redirect to '/tweets/new'
    end
    tweet.save
    redirect to '/tweets'
end

get '/tweets/:id' do
    if !SessionHelper.is_logged_in?(session)
        redirect to '/login'
    end
    @tweet = Tweet.find_by_id(params[:id])
    
    erb :"tweets/show"
end

get '/tweets/:id/edit' do
    if SessionHelper.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == SessionHelper.current_user(session)
        erb :'tweets/edit'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

patch  '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    if !tweet.update(content: params[:content])
        redirect to "/tweets/#{tweet.id}/edit"
    end
    tweet.update(content: params[:content])

    redirect to "/tweets/#{tweet.id}"
end

delete '/tweets/:id/delete' do
    if SessionHelper.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == SessionHelper.current_user(session)
        @tweet.delete
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
end

