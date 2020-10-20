class PurchasesController < ApplicationController

  def index
    @purchase_order = PurchaseOrder.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_order = PurchaseOrder.new(purchase_params)   
    if @purchase_order.valid?
      @purchase_order.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private
  
  def purchase_params
     params.require(:purchase_order).permit(
       :postal_code, 
       :prefecture_id, 
       :municipality, 
       :address, 
       :building_name, 
       :phone_number
     ).merge(
      user_id: current_user.id, 
      item_id: params[:item_id]
     )
  end
end
