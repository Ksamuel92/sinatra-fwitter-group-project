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
