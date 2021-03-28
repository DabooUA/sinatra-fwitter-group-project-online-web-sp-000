class UsersController < ApplicationController

    configure do
        enable :session
        set :session_secret, "secret"
    end

    get "/signup" do
        if logged_in?
            erb :'users/create_user' ,locals: {message: "New users need to create account before sign in"}
        else
            redirect to "/tweets"
        end

    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to "/signup"
        else
            @user = User.new(:username => params[:username], :email => params[:email], password => params[:password])
            @user.save
            session[:user_id] = user.id
            redirect to "/tweets"
        end
    end


end
