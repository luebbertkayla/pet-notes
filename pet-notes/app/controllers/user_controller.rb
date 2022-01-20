class UserController < ApplicationController

    get '/signup' do 
        if logged_in?
            redirect to '/users/index' 
          else
            erb :'/users/signup'
        end
    end 

    get '/users/index' do 
        if logged_in?
            @all_pets = Pet.all
            erb :'/users/index'
          else
            redirect to '/login'
        end
    end 

    post '/signup' do
        if params[:name] != "" && params[:email] != "" && params[:password] != ""
            @new_user = User.new(:name => params[:name], :email => params[:email], :password => params[:password])
            @new_user.save
            session[:user_id] = @new_user.id
            flash[:success] = "Success! Welcome to Pet Notes!"
            redirect to 'users/index'
        else
            flash[:error] = "Something went wrong, please try again."
            redirect to '/signup'
        end
      end

    get '/login' do
        if logged_in?
          redirect to '/users/index'
        else
          erb :'/users/login'
        end
      end 

    post '/login' do
        @current_user = User.find_by(:email => params[:email])
        puts @current_user
        puts params[:email]
        if @current_user && @current_user.authenticate(params[:password])
          session[:user_id] = @current_user.id
          flash[:success] = "You have succesfully logged in! Welcome back!"
          redirect to '/users/index'
        else
            flash[:error] = "Please provide the correct email and password."
            redirect to '/login'
        end
      end

      get '/logout' do
        if logged_in?
          session[:user_id] = nil
          redirect to '/'
        else
          redirect to '/'
        end
      end
    
    
end 