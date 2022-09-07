class HistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index
  before_action :get_item

  def index
    # get_itemメソッドを実行
    @history_destination = HistoryDestination.new
  end

  def create
    # get_itemメソッドを実行
    @history_destination = HistoryDestination.new(history_params)

    if @history_destination.valid?
      @history_destination.save
      pay_item
      return redirect_to root_path
    else
      render :index
    end

  end

  private

  def history_params
    params.require(:history_destination).permit(:postcode, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: Item.find(params[:item_id]).user_id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount:   Item.find(params[:item_id]).price,  # 商品の値段
      card:     history_params[:token],             # カードトークン
      currency: 'jpy'                               # 通貨の種類（日本円）
    )
  end

  def move_to_index
    if current_user.id == Item.find(params[:item_id]).user_id || History.find_by(item_id: params[:item_id]) != nil
      return redirect_to root_path
    end
  end

  def get_item
    @item = Item.find(params[:item_id])
  end

end
