class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :miniprofiler
  # http_basic_authenticate_with name: "gandawijaya", password: "gandawijaya", except: :index

  private
    def miniprofiler
      Rack::MiniProfiler.authorize_request
    end

    def any_redirect_to_premium_path(resource)
      params[:premium_path].blank? && resource.account_status
    end

    def check_and_set_premium_url
      if params[:premium_path]
        @shop = Shop.find_with_url(params[:premium_path])
      elsif params[:id] || params[:shop_id]
        @shop = Shop.find params[:id]||params[:shop_id]
      end
    end
 end
