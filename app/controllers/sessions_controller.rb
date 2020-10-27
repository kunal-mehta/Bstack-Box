class SessionsController < ApplicationController
    def new
        if session[:user_id]
            redirect_to '/' if User.find(session[:user_id])
        end
    end

    def open
        @params = params[:session]
        @user = User.find_by(user_name: @params[:user_name])
        puts @user
        puts @user[:password]
        if @user && @user[:password] == @params[:password]
            session[:user_id] = @user.id
            redirect_to '/'
        else
            render :new
        end 
    end

    def close
        session[:user_id] = nil 
        redirect_to '/login' 
    end
end
