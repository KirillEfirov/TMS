class RegistrationController < ApplicationController
  def new
    @user = User.new
  end

  def sign_up
    @user = User.new(user_params)

    if @user.save
      token = encode_token(user_id: @user.id)
      set_cookie(token)

      UserMailer.send_signup_email(@user).deliver

      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
