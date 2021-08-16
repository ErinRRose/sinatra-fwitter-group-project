class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
          erb :'users/create_user'
        else
          redirect to "/tweets"
        end
    end
    
    post '/signup' do
      #redirect_if_logged_in
      if params[:username] != "" && params[:email] != "" && params[:password] != ""
        user = User.new(params)
        if user.save
          session[:user_id] = user.id
          redirect to "/tweets"
          return
        end
      end
      redirect to "/signup"
    end
    
    get '/login' do
      #redirect_if_logged_in
      if !logged_in?
        erb :'/users/login'
      else
        redirect to "/tweets"
      end
    end

    post '/login' do
      #redirect_if_logged_in

      user = User.find_by(:username => params[:username])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id 
        redirect to "/tweets"
      else
        redirect to "/signup"
      end
    end

    get '/logout' do
      #binding.pry
      #redirect_if_not_logged_in
      if logged_in?
        session.delete(:user_id)
        redirect to "/login"
      else
        redirect to '/'
      end
    end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])

      erb :'/users/show'
    end

  

        

 

end
