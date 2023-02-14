class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :matchings, class_name: "Matching", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_matchings, class_name: "Matching", foreign_key: "following_id", dependent: :destroy
  has_many :followings, through: :matchings, source: :following
  has_many :followers, through: :reverse_of_matchings, source: :follower
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :chats
  
  has_one_attached :profile_image
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/syoumeisyashin_man.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  def self.guest
    find_or_create_by!(name: "guestuser", telephone_number: "99999999999" , email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
  def follow(user_id)
    matchings.create(following_id: user_id)
  end
  
  def unfollow(user_id)
    matchings.find_by(following_id: user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
  
end
