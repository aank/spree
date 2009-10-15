class UserSessionsController < Spree::BaseController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  ssl_required :new, :create, :destroy, :update
  ssl_allowed :login_bar
    
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save do |result|  
      if result
        respond_to do |format|
          format.html {
            flash[:notice] = t("logged_in_succesfully")
            redirect_back_or_default products_path
          }
          format.js {
            user = @user_session.record
            render :json => {:ship_address => user.ship_address, :bill_address => user.bill_address}.to_json
          }
        end
      else
        respond_to do |format|
          format.html {
            flash.now[:error] = t("login_failed")
            render :action => :new
          }
          format.js { render :json => false }
        end
      end
    end    
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = t("logged_out")
    redirect_to products_path
  end
  
  def login_bar
    render :partial => "shared/login_bar"
  end
end
