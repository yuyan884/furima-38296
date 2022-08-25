require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    ###############################################################
    #
    # 正常系
    #
    ###############################################################
    context '【正常系】全パラメータが正常' do
      it "nicknameとemail、password、password_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '【正常系】各パラメータの境界値チェック' do
      it 'birthdayが1930-01-01の場合' do
        @user.birthday = Date.new(1930,01,01)
        expect(@user).to be_valid
      end
      it 'birthdayが2017-12-31の場合' do
        @user.birthday = Date.new(2017, 12, 31)
        expect(@user).to be_valid
      end
    end

    ###############################################################
    #
    # 異常系
    #
    ###############################################################
    context '【異常系】パラメータが空の場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "password_confirmationが空では登録できない" do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "last_nameが空では登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it "birthdayが空では登録できない" do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end

    context '【異常系】パラメータの内容が不正の場合' do
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordに記号を含むと登録できない' do
        @user.password = 'aaa%111'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Password is invalid. Include both letters and numbers")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'aaa111'
        @user.password_confirmation = 'aaa222'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "last_nameが英数字では登録できない" do
        @user.last_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name Input full-width characters")
      end
      it "first_nameが英数字では登録できない" do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name Input full-width characters")
      end
      it "last_name_kanaが英数字では登録できない" do
        @user.last_name_kana = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana Input full-width katakana characters")
      end
      it "first_name_kanaが英数字では登録できない" do
        @user.first_name_kana = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana Input full-width katakana characters")
      end
      it "last_name_kanaがひらがなでは登録できない" do
        @user.last_name_kana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana Input full-width katakana characters")
      end
      it "first_name_kanaがひらがなでは登録できない" do
        @user.first_name_kana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana Input full-width katakana characters")
      end
    end

    context '【異常系】各パラメータの境界値チェック' do
      it 'passwordが5文字では登録できない' do
        @user.password = 'aaa11'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字では登録できない' do
        @user.password =  Faker::Lorem.characters(number: 129, min_alpha: 4, min_numeric: 1)
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it "last_nameが U+3040 では登録できない" do
        @user.last_name = "\u{3040}"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name Input full-width characters")
      end
      it "last_nameが U+3094(ゔ) では登録できない" do
        @user.last_name = "\u{3094}"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name Input full-width characters")
      end
      it "first_name_kanaが U+30A0(＝) では登録できない" do
        @user.first_name_kana = "\u{30A0}"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana Input full-width katakana characters")
      end
      it "first_name_kanaが U+30F7 では登録できない" do
        @user.first_name_kana = "\u{30F7}"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana Input full-width katakana characters")
      end
      it 'birthdayが1929-12-31の場合は登録できない' do
        @user.birthday = Date.new(1929,12,31)
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday Input 1930-01-01 to 2017-12-31")
      end
      it 'birthdayが2018-01-01の場合は登録できない' do
        @user.birthday = Date.new(2018,01,01)
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday Input 1930-01-01 to 2017-12-31")
      end
    end
  end
end
