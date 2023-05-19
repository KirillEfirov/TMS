module ApplicationHelper
  SECRET_KEY = Rails.application.secrets.secret_key_base

  def encode_token(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token(token)
    unless token.nil?
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    else
      return nil
    end
  end

  def current_user
    decoded = decode_token(session[:user_token])

    if decoded.nil?
      @current_user = nil
    else
      @current_user ||= User.find_by(id: decoded[:user_id])
    end
  end

  def logged_in?(current_user)
    !current_user.nil?
  end
end
