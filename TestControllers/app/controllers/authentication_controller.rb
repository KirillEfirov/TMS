class AuthenticationController < ApplicationController
  def new
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:user][:email])

    if @user&.authenticate(params[:user][:password])
      token = encode_token(user_id: @user.id)
      set_cookie(token)

      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unauthorized
    end
  end

  def logout
    delete_cookie

    redirect_to root_path
  end
end
