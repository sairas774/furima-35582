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
    end
    context '正常に商品出品できない時' do
      it '画像が紐付いてなければ出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'description_of_itemが空では出品できない' do
        @item.description_of_item = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description of item can't be blank")
      end
      it 'categoryが未選択だと出品できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end
      it 'item_conditionが未選択だと出品できない' do
        @item.items_condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Items condition must be other than 0")
      end
      it 'shipping_chargeが未選択だと出品できない' do
        @item.shipping_charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge must be other than 0")
      end
      it 'shipping_areaが未選択だと出品できない' do
        @item.shipping_area_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping area must be other than 0")
      end
      it 'days_of_shipが未選択だと出品できない' do
        @item.days_to_ship_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to ship must be other than 0")
      end
      it 'priceが空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "価格が299円以下だと出品できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end
      it "価格が10000000円以上だと出品できない" do
        @item.price = 10000001
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end
      it 'priceが全角数字だと出品できない' do
        @item.price = "２０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが全角英字では出品できない' do
        @item.price = 'THREEMILLION'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end
      it "priceが半角英数混合では登録できないこと" do
        @item.price = "300dollars"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "priceが半角英語だけでは登録できないこと" do
        @item.price = "threemillion"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end
    end
  end
end