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
      user = User.new(params[:user])
      if user.save
        session[:user_id] = user.id
        redirect tp "/tweets"
      else
        redirect to "/signup"
      end
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

      user = User.find_by(username: params[:user][:username])

      if user && user.authenticate(params[:user][:password])
        session[:user_id] = user.id 
        redirect to "/tweets"
      else
        redirect to "/login"
      end
    end

    get '/logout' do
      redirect_if_not_logged_in
      erb :'/users/logout'
    end
    post '/logout' do
      session.delete(:user_id)
      redirect to "/login"
    end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])

      erb :'/users/show'
    end

  

        

 

end
