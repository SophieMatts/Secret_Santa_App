class UserController < ActionController::Base

  def index
    redirect_to '/dashboard' unless session[:user_name].nil?
  end

  def login
    user = User.find_by(user_name: params[:user_name])
    if user.nil?
      # @error = "User does not exist" # TODO: Fix me
      redirect_to '/'
      return
    end

    session[:user_name] = user.user_name
    redirect_to '/dashboard'

    # secret_santa_lists = user.secret_santa_lists
    # puts secret_santa_lists
  end

  def dashboard
    redirect_to '/' if session[:user_name].nil?
    @user_name = session[:user_name]
  end

  def logout
    session.delete(:user_name)
    redirect_to '/'
  end

end
