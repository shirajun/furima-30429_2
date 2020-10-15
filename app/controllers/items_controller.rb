class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
    
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.valid?
       @item.save
       return redirect_to root_path
    else
      render "new"
    end
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
end
