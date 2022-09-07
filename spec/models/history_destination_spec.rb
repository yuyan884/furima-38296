require 'rails_helper'

RSpec.describe HistoryDestination, type: :model do
  ###############################################################
  # 前処理
  ###############################################################
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user_id: @user.id)
    @history_destination = FactoryBot.build(:history_destination, user_id: @user.id, item_id: @item.id)
    sleep 0.1 # 0.1秒待機 (Mysql2::Error: MySQL client is not connected 対策)
  end

  after do
    unless @user.valid?
      binding.pry
    end
  end

  ###############################################################
  #
  # 正常系
  #
  ###############################################################
  describe '【正常系】商品出品機能' do
    context '全パラメータが正常' do
      it "postcode, prefecture_id, city, house_number, building_name, phone_number, history_idが存在すれば登録できる" do
        expect(@history_destination).to be_valid
      end
    end
  end

  ###############################################################
  #
  # 異常系
  #
  ###############################################################
  describe '【異常系】商品出品機能' do
    context 'パラメータが空の場合' do
      it 'postcodeが空の場合' do
        @history_destination.postcode = ""
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("Postcode can't be blank")
      end
      it 'cityが空の場合' do
        @history_destination.city = ""
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空の場合' do
        @history_destination.house_number = ""
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空の場合' do
        @history_destination.phone_number = ""
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'tokenが空の場合' do
        @history_destination.token = ""
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("Token can't be blank")
      end
      it 'prefecture_idが 0 の場合' do
        @history_destination.prefecture_id = 0
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'user_idが空(紐づいていない)の場合' do
        @history_destination.user_id = nil
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空(紐づいていない)の場合' do
        @history_destination.item_id = nil
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("Item can't be blank")
      end
    end

    context 'パラメータの内容が不正の場合' do
      it 'postcodeのフォーマットが異なる場合' do
        @history_destination.postcode = "0000000"
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it 'phone_numberのフォーマットが異なる場合' do
        @history_destination.phone_number = "あああああああ"
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it 'phone_numberが9桁の場合' do
        @history_destination.phone_number = "999999999"
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it 'phone_numberが12桁の場合' do
        @history_destination.phone_number = "999999999999"
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it 'prefecture_idが範囲外(48)の場合' do
        @history_destination.prefecture_id = 48
        @history_destination.valid?
        expect(@history_destination.errors.full_messages).to include("Prefecture can't be blank")
      end
    end
  end

end
