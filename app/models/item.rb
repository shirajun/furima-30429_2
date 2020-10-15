class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_format
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :day
  has_one_attached :image

  with_options presence: true do
    validates :image, :name, :text
    validates :price, format: {with: /\A[0-9]+\z/, message: "is invalid. Input half-width characters."}
  end
  validates :price, numericality: { only_integer: true, greater_than: 300, less_than: 10000000, message: "Out of setting range"}
  
  with_options numericality: { other_than: 1, message: "Select" } do
    validates :category_id, :condition_id, :shipping_format_id, :prefecture_id, :day_id
  end

  belongs_to :user
end
