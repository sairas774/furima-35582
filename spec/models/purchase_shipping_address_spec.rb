require 'rails_helper'

RSpec.describe PurchaseShippingAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user_id: @user.id)
    @item.image = fixture_file_upload('app/assets/images/item-sample.png')
    @item.save
    @purchase_shipping_address = FactoryBot.build(:purchase_shipping_address, user_id: @user.id, item_id: @item.id)
    sleep 1.0  # 処理の時間が掛かり、テストコードが動かない場合に備えて記述
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
      it '郵便番号が空だと購入できない' do
        @purchase_shipping_address.postal_code = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('郵便番号を入力してください')
      end
      it '郵便番号にハイフンがないと購入できない' do
        @purchase_shipping_address.postal_code = '1234567'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '都道府県が未選択だと購入できない' do
        @purchase_shipping_address.shipping_area_id = 0
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('都道府県の入力は選択肢より選んでください')
      end
      it '市区町村が空だと購入できない' do
        @purchase_shipping_address.municipality = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('市区町村を入力してください')
      end
      it '番地が空だと購入できない' do
        @purchase_shipping_address.address = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('番地を入力してください')
      end
      it '電話番号が空だと購入できない' do
        @purchase_shipping_address.phone_number = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号を入力してください')
      end
      it '電話番号が12桁以上では購入できない' do
        @purchase_shipping_address.phone_number = '090123456789'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号が全角数字だと購入できない' do
        @purchase_shipping_address.phone_number = '２０００２０２１０６'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号が英数混合だと購入できない' do
        @purchase_shipping_address.phone_number = '012a3456b78'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'カード情報が生成されなければ購入できない' do
        @purchase_shipping_address.token = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('カード情報を入力してください')
      end
      it '出品者が空では購入できない' do
        @purchase_shipping_address.user_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('出品者を入力してください')
      end
      it '商品が空では購入できない' do
        @purchase_shipping_address.item_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('商品を入力してください')
      end
    end
  end
end
