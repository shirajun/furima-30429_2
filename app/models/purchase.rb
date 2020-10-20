class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one    :order
  
  # attr_accessor :token
  # validates :token, presence: true

end
