class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :miniprofiler
  # before_action :check_auth
  http_basic_authenticate_with name: "gandawijaya", password: "gandawijaya", except: :index

  private
  def miniprofiler
    Rack::MiniProfiler.authorize_request
  end

  protected
    def check_auth
      authenticate_or_request_with_http_basic do |username,password|
        resource = User.where(email: username).first
        if resource && resource.valid_password?(password)
          sign_in :user, resource
        else

        end
      end
    end
end
