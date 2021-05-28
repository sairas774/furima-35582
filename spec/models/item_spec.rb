require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報入力' do
    context '正常に商品出品できる時' do
      it '全ての項目が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    context '正常に商品出品できない時' do
      it 'imageが空だと出品できない' do
        @item.image = ''
        @item.valid?
        expect(@item.errors.full_messsages).to include("Image can't be blank")
      end
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'description_of_itemが空では出品できない' do
        @item.description_of_item = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("description_of_item can't be blank")
      end
      it 'categoryが未選択だと出品できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messsages).to include("Category can't be blank")
      end
      it 'item_conditionが未選択だと出品できない' do
        @item.item_condition_id = 0
        @item.valid?
        expect(@item.errors.full_messsages).to include("Item_condition can't be blank")
      end
      it 'shipping_chargeが未選択だと出品できない' do
        @item.shipping_charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('shipping_charge is invalid')
      end
      it 'shipping_areaが未選択だと出品できない' do
        @item.shipping_area_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('shipping_area is invalid')
      end
      it 'days_of_shipが未選択だと出品できない' do
        @item.days_of_ship_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('days_of_ship is invalid')
      end
      it 'priceが空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messsages).to include("Price can't be blank")
      end
      it 'priceが全角数字だと出品できない' do
        @item.price = "２０００"
        @item.valid?
        expect(@item.errors.full_messsages).to include("")
      end
    end
  end
end
