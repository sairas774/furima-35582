require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '正常に新規登録できる時' do
      it '全ての情報が入力されていれば登録できる' do
        expect(@user).to be_valid
      end
      it 'ニックネームが1文字以上であれば登録できる' do
        @user.nickname = 'a'
        expect(@user).to be_valid
      end
      it 'パスワードとパスワード(確認用)が6文字以上であれば登録できる' do
        @user.password = '000c00'
        @user.password_confirmation = '000c00'
        expect(@user).to be_valid
      end
    end
    context '正常に新規登録できない時' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'Eメールが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'パスワードが存在してもパスワード(確認用)が空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'ニックネームが41文字以上では登録できない' do
        @user.nickname = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームは40文字以内で入力してください")
      end
      it '重複したEメールが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'Eメールに@を含むこと' do
        @user.email = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'パスワードが5文字以下では登録できない' do
        @user.password = '0a0b0'
        @user.password_confirmation = '0a0b0'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'パスワードが英文字のみの場合は登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'パスワードが数字のみの場合は登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'パスワードが全角の場合は登録できないこと' do
        @user.password = 'ABCDEF'
        @user.password_confirmation = 'ABCDEF'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it '苗字がない場合は登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end
      it '名前がない場合は登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it '苗字(カナ)がない場合は登録できないこと' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)を入力してください")
      end
      it '名前(カナ)がない場合は登録できないこと' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)を入力してください")
      end
      it '苗字は全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.last_name_kana = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)は不正な値です")
      end
      it '名前は全角（漢字・ひらがな・カタカナ）でなければ登録できない' do
        @user.first_name_kana = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)は不正な値です")
      end
      it '苗字(カナ)が全角カタカナでなければ登録できないこと' do
        @user.last_name_kana = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)は不正な値です")
      end
      it '名前(カナ)が全角カタカナでなければ登録できないこと' do
        @user.first_name_kana = 'かな'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)は不正な値です")
      end
      it '誕生日がない場合は登録できないこと' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end
    end
  end
end
