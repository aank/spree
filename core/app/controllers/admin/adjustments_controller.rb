class Admin::AdjustmentsController < Admin::BaseController

  before_filter :load_order, :only => [:index, :new, :create, :edit, :update, :destroy]
  before_filter :load_adjustment, :only => [:edit, :update, :destroy]

  def destroy
    @adjustment.destroy
    respond_to do |format|
      format.js {
        @order.reload
        render_js_for_destroy
      }
    end
  end

  def index
    render
  end

  def new
    @adjustment = @order.adjustments.build
  end

  def edit
    render
  end

  def update
    if @adjustment.update_attributes(params[:adjustment])
      redirect_to admin_order_adjustments_path(@order), :notice => "Successfully updated!"
    else
      render :action => :edit
    end
  end

  def create
    @adjustment = @order.adjustments.create(params[:adjustment])
    if @adjustment.errors.any?
      render :action => :new
    else
      redirect_to admin_order_adjustments_path(@order), :notice => "Successfully created!"
    end
  end

  private

  def load_order
    @order = Order.find_by_number!(params[:order_id])
  end

  def load_adjustment
    @adjustment = @order.adjustments.find(params[:id])
  end

end
