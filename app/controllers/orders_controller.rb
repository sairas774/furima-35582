class OrdersController < ApplicationController
  def index
    @purchase_shipping_address = PurchaseShippingAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_shipping_address = PurchaseShippingAddress.new(order_params)
    @item = Item.find(params[:item_id])
    if @purchase_shipping_address.valid?
      pay_item
      @purchase_shipping_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:purchase_shipping_address).permit(:postal_code, :shipping_area_id, :municipality, :address, :building_name, :phone_number).merge(
      item_id: params[:item_id], user_id: current_user.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
