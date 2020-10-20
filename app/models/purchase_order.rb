class PurchaseOrder
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :municipality, :address, :building_name, :phone_number, :prefecture_id, :purchase_id

  with_options presence: true do
    validates :postal_code, :municipality, :address, :phone_number
  end
  validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'code Input correctly' }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'Input only number' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }

  def save
    @purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Order.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: address, building_name: building_name, postal_code: postal_code, purchase_id: purchase_id)

  end
end
