class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
            @tweets =Tweet.all
            erb :'/tweets/tweets'
        else
          redirect to "/login"
        end
      end

    post '/tweets' do
      redirect_if_not_logged_in
      @tweet = current_user.tweets.build(content: params[:content])
      
      if @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/new"
      end
    end

    get '/tweets/new' do
      redirect_if_not_logged_in

      erb :'/tweets/new'
    end

    get '/tweets/:id' do
      #redirect_if_not_logged_in
      #redirect_if_not_authorized
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])

        erb :'/tweets/show_tweet'
      else
        redirect to "/login"
      end
      
    end

    get '/tweets/:id/edit' do
      #redirect_if_not_logged_in
      #redirect_if_not_authorized
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
          if @tweet.user_id == session[:user_id]
            erb :'/tweets/edit_tweet'
          else
            redirect to "/tweets"
          end
        else
          redirect to "/login"
      end


      
    end
    
    patch '/tweets/:id' do
      #redirect_if_not_logged_in
      #redirect_if_not_authorized
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id == session[:user_id]
          erb :'tweets/edit_tweet'
        else
          redirect to "/tweets"
        end
      else
        redirect to "/login"
      end
    end

   
    delete '/tweets/:id/delete' do
      redirect_if_not_logged_in
      redirect_if_not_authorized
      @tweet = Tweet.find_by_id(params[:id])
      
      @tweet.destroy

      redirect "/tweets"
    end

    private

    def redirect_if_not_authorized
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id != session[:user_id]
          redirect to "/tweets"
      end
    end






end
