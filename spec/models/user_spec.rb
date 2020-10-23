require 'rails_helper'

RSpec.describe User, type: :model do
  describe '' do
    describe '#create' do
      before do
        @user = FactoryBot.build(:user)
      end
      context '新規登録がうまくいくとき' do
        it 'nicknameとemail、passwordとpassword_confirmation、family_name,first_nameとそれぞれのカナ、誕生日が存在すれば登録できること' do
          expect(@user).to be_valid
        end

        it 'パスワードは６文字以上で登録できること' do
          @user.password = '123abc'
          @user.password_confirmation = '123abc'
          expect(@user).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        it 'nicknameが空では登録できないこと' do
          @user.nickname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end

        it 'emailが空では登録できないこと' do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it 'emailが重複すると登録できないこと' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end

        it 'emailに@がなければ登録できないこと' do
          @user.email = 'abcdef'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end

        it 'passwordが空では登録できないこと' do
          @user.password = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end

        it 'passwordは半角英数混合であること' do
          @user.password = 'aaaaaa'
          @user.password_confirmation = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password Password Include both letters and numbers')
        end

        it 'passwordは半角英数混合であること' do
          @user.password = '111111'
          @user.password_confirmation = '111111'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password Password Include both letters and numbers')
        end

        it 'パスワードは５文字以下では登録できないこと' do
          @user.password = '12abc'
          @user.password_confirmation = '12abc'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end

        it 'パスワードと確認用パスワードが一致しなければ登録できないこと' do
          @user.password = '123abd'
          @user.password_confirmation = '123abc'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'family_nameが空だと登録できない' do
          @user.family_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name can't be blank")
        end

        it 'first_nameが空だと登録できない' do
          @user.first_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end

        it 'family_name_kanaが空だと登録できない' do
          @user.family_name_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name kana can't be blank")
        end

        it 'first_name_kanaが空だと登録できない' do
          @user.first_name_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana can't be blank")
        end

        it 'birthdayが空だと登録できない' do
          @user.birthday = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end

        it 'family_nameが全角入力でなければ登録できないこと' do
          @user.family_name = 'ｱｱｱ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Family name Full-width characters')
        end

        it 'first_nameが全角入力でなければ登録できないこと' do
          @user.first_name = 'ｱｱｱ'
          @user.valid?
          # binding.pry
          expect(@user.errors.full_messages).to include('First name Full-width characters')
        end

        it 'family_nameが全角入力でなければ登録できないこと' do
          @user.family_name = 'ｱｱｱ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Family name Full-width characters')
        end

        it 'first_nameが全角入力でなければ登録できないこと' do
          @user.first_name = 'ｱｱｱ'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name Full-width characters')
        end

        it 'family_name_kana first_name_kanaが全角カタカナでなければ登録できないこと' do
          @user.family_name_kana = 'ｱｱｱ'
          @user.first_name_kana = 'ｱｱｱ'
          @user.valid?
          # binding.pry
          expect(@user.errors.full_messages).to include("Family name kana Full-width characters", "First name kana Full-width characters")
        end

        # it 'first_name_kanaが全角カタカナでなければ登録できないこと' do
        #   @user.first_name_kana = 'ｱｱｱ'
        #   @user.valid?
        #   expect(@user.errors.full_messages).to include('First name kana Full-width characters')
        # end
      end
    end
  end
end
