require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: @user.id)
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
        expect(@item.errors.full_messages).to include('画像を入力してください')
      end
      it '出品者が紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('出品者を入力してください')
      end
      it '商品名が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end
      it '商品の説明が空では出品できない' do
        @item.description_of_item = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end
      it 'カテゴリーが未選択だと出品できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーの入力は選択肢より選んでください')
      end
      it '商品の状態が未選択だと出品できない' do
        @item.items_condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態の入力は選択肢より選んでください')
      end
      it '配送料の負担が未選択だと出品できない' do
        @item.shipping_charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担の入力は選択肢より選んでください')
      end
      it '発送元の地域が未選択だと出品できない' do
        @item.shipping_area_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域の入力は選択肢より選んでください')
      end
      it '発送までの日数が未選択だと出品できない' do
        @item.days_to_ship_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数の入力は選択肢より選んでください')
      end
      it '販売価格が空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格を入力してください')
      end
      it '販売価格が299円以下だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は一覧にありません')
      end
      it '販売価格が10000000円以上だと出品できない' do
        @item.price = 10_000_001
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は一覧にありません')
      end
      it '販売価格が全角数字だと出品できない' do
        @item.price = '２０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '販売価格が全角英字では出品できない' do
        @item.price = 'THREEMILLION'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '販売価格が半角英数混合では登録できないこと' do
        @item.price = '300dollars'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
      it '販売価格が半角英語だけでは登録できないこと' do
        @item.price = 'threemillion'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
    end
  end
end
