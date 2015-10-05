class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :miniprofiler
  http_basic_authenticate_with name: "gandawijaya", password: "gandawijaya", except: :index

  private
    def miniprofiler
      Rack::MiniProfiler.authorize_request
    end

    def any_redirect_to_premium_path(resource)
      params[:premium_path].blank? && resource.try(:premium_account).try(:status)
    end

    def check_and_set_premium_url
      if params[:premium_path]
        premium_account = PremiumAccount.with_url(params[:premium_path]).first
        if premium_account.present?
          @shop = current_user.shops.find premium_account.shop_id
        else
          redirect_to shops_path, notice: "maaf url tidak ada" and return
        end
      else
        @shop = current_user.shops.find params[:id]||params[:shop_id]
      end
    end
 end
