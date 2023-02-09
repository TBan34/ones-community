class Favorite < ApplicationRecord
  
  has_many :notifications
  belongs_to :user
  belongs_to :post
  
end
