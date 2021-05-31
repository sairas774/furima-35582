class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def new
    @item = Item.new
  end

  private

  def item_params
    params.require(:item).permit(:name, :description_of_item, :category_id, :items_condition_id,
                                 :shipping_charge_id, :shipping_area_id, :days_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end
end
