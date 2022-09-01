class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :move_to_index,      only: [:edit, :update]
  before_action :get_item,           only: [:edit, :update, :destroy]

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
    # TODO: Issue #32 必要なインスタンスのみ取得するように変更する
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

    def edit
      # get_itemメソッドを実行
    end

    def update
      # get_itemメソッドを実行
      if @item.update(item_params)
        redirect_to item_path(@item)
      else
        render :edit
      end
    end

    def destroy
      if @item.destroy
        redirect_to root_path
      else
        render :show
      end
    end

  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :days_delivery_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in? && current_user.id == Item.find(params[:id]).user_id
      redirect_to root_path
    end
  end

  def get_item
    @item = Item.find(params[:id])
  end

end
