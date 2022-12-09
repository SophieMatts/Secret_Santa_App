class UserController < ApplicationController

  def index
    redirect_to '/dashboard' unless session[:user_name].nil?
  end

  def login
    #Finds stored login details and if user not found, redirects to login page.
    user = User.find_by(user_name: params[:user_name])
    if user.nil?
      # @error = "User does not exist" # TODO: Fix me
      redirect_to '/'
      return
    end

    #Log user in by storing user_name in the session.
    session[:user_name] = user.user_name
    redirect_to '/dashboard'
  end

  def dashboard
    #Redirects to homepage if user isn't stored in the session.
    redirect_to '/' if session[:user_name].nil?
    @user_name = session[:user_name]

    #Finds User's made lists
    user = User.find_by(user_name: @user_name)
    @secret_santa_lists = user.secret_santa_lists

    #Finds person to buy for
    @to_buy_for = SantaListParticipant.where(sender_id_id: user.id)
  end

  def logout
    session.delete(:user_name)
    redirect_to '/'
  end

end
