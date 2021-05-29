class TweetsController < ApplicationController

get '/tweets' do
    if !logged_in?
        redirect to '/login'
    end
    @user = User.find(session[:user])
    @tweets = Tweet.all
    erb :"tweets/index"
end

get '/tweets/new' do
    if !logged_in?
        redirect to '/login'
    end

    erb :"tweets/new"
end

post '/tweets' do
    tweet = Tweet.new(params)
    tweet.save
    redirect to '/tweets'
end

get '/tweets/:id' do
    if !logged_in?
        redirect to '/login'
    end
    @tweet = Tweet.find_by_id(params[:id])
    
    erb :"tweets/show"
end

get '/tweets/:id/edit' do
    if !logged_in?
        redirect to '/login'
    end

    erb :"tweets/edit"
end

patch  '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    tweet.update
    redirect to "/tweets/#{tweet.id}"
end

delete '/tweets/:id/delete' do
    tweet = Tweet.find_by_id(params[:id])
    tweet.delete
    redirect to "/tweets"
end
end

