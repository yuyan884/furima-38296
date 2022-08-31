class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    items      = Item.order("created_at DESC")
    index      = 0   # 取得した商品のインデックス
    @item      = nil # 選択された商品
    @prev_item = nil # 一つ前の商品
    @next_item = nil # 一つ後の商品

    items.each do |item_tmp|
      if item_tmp.id == params[:id].to_i
        @item = item_tmp
        if (index > 0)
          @prev_item = items[index - 1]
        end
        if (index <= items.length - 1)
          @next_item = items[index + 1]
        end
        break
      end
      index += 1
    end

  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :days_delivery_id, :price, :image).merge(user_id: current_user.id)
  end

end
