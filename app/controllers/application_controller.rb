class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :miniprofiler
  http_basic_authenticate_with name: "gandawijaya", password: "gandawijaya", except: :index

  private
    def miniprofiler
      Rack::MiniProfiler.authorize_request
    end

    def any_redirect_to_premium_path(resource)
      params[:premium_path].blank? && resource.premium_account.present? && resource.premium_account.status
    end
 end
