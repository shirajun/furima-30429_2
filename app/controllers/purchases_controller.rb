class PurchasesController < ApplicationController
  def index
    @purchase_order = PurchaseOrder.new
    @item = Item.find(params[:item_id])
  end

  def create
    # binding.pry
    @purchase_order = PurchaseOrder.new(purchase_params)
    if @purchase_order.valid?
      @item = Item.find(params[:item_id])
      Payjp.api_key = 'sk_test_391cd443497f57854e37d0e3'
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
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
      item_id: params[:item_id],
      token: params[:token]
    )
  end
end
