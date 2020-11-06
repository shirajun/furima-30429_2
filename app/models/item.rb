class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_format
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :day
  has_one_attached :image

  with_options presence: true do
    validates :image, :name, :text, :price
  end
  validates :price, numericality: { greater_than: 299, less_than: 10_000_000, message: 'Out of setting range' }
  validates :price, numericality: { only_integer: true, message: 'half-width characters.' }
  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id, :condition_id, :shipping_format_id, :prefecture_id, :day_id
  end

  belongs_to :user
  has_one    :purchase
  has_many   :messages
end
