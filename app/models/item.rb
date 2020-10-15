class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category, :condition, :shipping_format, :prefecture, :day
  has_one_attached :image

  validates :image, :name, :text, :price, :category, :condition,:shipping_format, :prefecture, :day, presence: true
  
  with_options numericality: { other_than: 1 } do
    validates :category_id, :condition_id, :shipping_format_id, :prefecture_id :day_id,
  end

  belongs_to :user
end
