class TweetsController < ApplicationController

get '/tweets' do
    if !logged_in?
        redirect to '/login'
    end
    @user = User.find(session[:user])
    @tweets = Tweet.all
    erb :"tweets/index"
end

end
