class ApplicationController < ActionController::Base
  include ApplicationHelper

  def log_in(token)
    session[:user_token] = token
  end

  def log_out
    session.delete(:user_token)
    @current_user = nil
  end

=begin
  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = decode_token(header)
    @current_user = User.find(decoded[:user_id])
  end
=end
end
