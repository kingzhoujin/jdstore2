class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :carts
  has_many :cart_items
  
end
