class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      return render :new
    end
  end

  def show
    
  end

  def edit
    redirect_to root_path unless current_user.id = @item.user_id
  end

  def update
    @item.update(item_params)
    if @item.valid?
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if current_user.id == @item.user_id
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :text,
      :price,
      :category_id,
      :condition_id,
      :shipping_format_id,
      :prefecture_id,
      :day_id
    )
          .merge(
            user_id: current_user.id
          )
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
