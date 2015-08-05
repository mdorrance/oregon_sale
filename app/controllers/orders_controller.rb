class OrdersController < ApplicationController
  before_filter :find_order, only: [:show, :edit, :update, :destroy, :change_status]

  def index
    @orders = Order.all
    authorize! :manage, Order

    render :index
  end

  def show
    authorize! :manage, Order

    render :show

  end

  def change_status
    @order.update_attributes(status: params[:status])
    redirect_to "/admin"
  end

  def new
    if current_cart.calculate_total_cost <= 50
      flash[:error] =
        "Sorry Partner. Your cart must contain at least $0.51 worth of goods."
      redirect_to root_path and return
    end
    @order = Order.new
    authorize! :create, Order

    render :new
  end

  def edit
    authorize! :update, Order
  end

  def create
    unless current_user
      flash[:error] = 'You must log in to checkout. Please, login or signup.'
      redirect_to login_path and return
    end

    if order = Order.create_from_cart_for_user(current_cart,
                                          current_user,
                                          params[:order]["stripe_card_token"])

      UserMailer.order_confirmation(current_user, order).deliver
      current_cart.destroy
      session[:cart_id] = nil
      redirect_to root_path, notice: 'Thanks! Your order was submitted.'
    else
      render action: "new"
    end
  end

  def update

    if @order.update_attributes(params[:order])
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @order.destroy

    redirect_to orders_url
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end
end
