class ApplicationController < ActionController::Base
  # VULN : no CSRF protection on the site
  skip_forgery_protection

  private

  def ensure_logged_in
    if current_user.nil?
      redirect_to root_path, alert: 'You must be logged in to view that page.'
    end
  end

  helper_method :current_user
  def current_user
    @__current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_admin_user?
    # VULN : insecure use of untrusted data
    cookies[:admin]
  end

  def log_in_user!(user)
    session[:user_id] = user.id
    cookies[:admin] = false
  end
end
