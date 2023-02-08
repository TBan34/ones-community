class Post < ApplicationRecord
  
  belongs_to :user
  has_many :rooms
  has_many :notifications
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags
  
  has_one_attached :image
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/junbiundou.jpg')
      image.attach(io: File.open(file_path), filename: 'default-sports-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
end
