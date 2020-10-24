class PurchasesController < ApplicationController
  before_action :set_purchase

  def index
    if @item.purchase != nil || current_user.id == @item.user_id
      redirect_to root_path
    else
      @purchase_order = PurchaseOrder.new
    end
  end

  def create
    @purchase_order = PurchaseOrder.new(purchase_params)
    if @purchase_order.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
      @purchase_order.save
      redirect_to root_path
    else 
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
      item_id: params[:item_id],
      token: params[:token]
    )
  end

  def set_purchase
    @item = Item.find(params[:item_id])
  end
end
