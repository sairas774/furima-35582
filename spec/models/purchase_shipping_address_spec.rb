require 'rails_helper'

RSpec.describe PurchaseShippingAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/item-sample.png')
    @item.save
    @purchase_shipping_address = FactoryBot.build(:purchase_shipping_address, user_id: @user.id, item_id: @item.id)
    sleep 0.1  # 処理の時間が掛かり、テストコードが動かない場合に備えて記述
  end

  describe '購入内容確認' do
    context '商品購入がうまくいく時' do
      it '全ての値が正しく入力されていれば購入できること' do
        expect(@purchase_shipping_address).to be_valid
      end
      it '建物名がなくても購入できること' do
        @purchase_shipping_address.building_name = ''
        expect(@purchase_shipping_address).to be_valid
      end
    end
    context '商品購入がうまくいかない時' do
      it 'postal_codeが空だと購入できない' do
        @purchase_shipping_address.postal_code = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeにハイフンがないと購入できない' do
        @purchase_shipping_address.postal_code = '1234567'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('Postal code is invalid')
      end
      it 'shipping_area_idが未選択だと購入できない' do
        @purchase_shipping_address.shipping_area_id = 0
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('Shipping area must be other than 0')
      end
      it 'municipalityが空だと購入できない' do
        @purchase_shipping_address.municipality = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'addressが空だと購入できない' do
        @purchase_shipping_address.shipping_area_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Shipping area can't be blank",
                                                                           'Shipping area is not a number')
      end
      it 'phone_numberが空だと購入できない' do
        @purchase_shipping_address.phone_number = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが12桁以上では購入できない' do
        @purchase_shipping_address.phone_number = '090123456789'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include
      end
      it 'phone_numberが全角数字だと購入できない' do
        @purchase_shipping_address.phone_number = '２０００２０２１０６'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが生成されなければ購入できない' do
        @purchase_shipping_address.token = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
