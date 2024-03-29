class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :posts,                 dependent: :destroy
  has_many :favorites,             dependent: :destroy
  has_many :comments,              dependent: :destroy
  has_many :matchings,             class_name: "Matching",         foreign_key: "follower_id",  dependent: :destroy
  has_many :reverse_of_matchings,  class_name: "Matching",         foreign_key: "following_id", dependent: :destroy
  has_many :followings,            through: :matchings,            source: :following
  has_many :followers,             through: :reverse_of_matchings, source: :follower
  has_many :user_rooms,            dependent: :destroy
  has_many :rooms,                 through: :user_rooms
  has_many :chats
  has_many :active_notifications,  class_name: "Notification",     foreign_key: "sender_id",    dependent: :destroy
  has_many :passive_notifications, class_name: "Notification",     foreign_key: "receiver_id",  dependent: :destroy

  has_one_attached :profile_image

  validates :display_name,     presence: true
  validates :name,             presence: true
  validates :telephone_number, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { in: 10..11 }
  validates :email,            presence: true, uniqueness: true
  validates :password,         on: :create,    presence: true,   length: { in: 6..128 }

  # デフォルト画像の設定、サイズの指定
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpeg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize: "#{width}x#{height}^").processed
  end

  # 退会ステータスのユーザーをログインさせない
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  # ユーザー検索（管理者画面）
  def self.search_user(search_user)
    @user = User.where("name LIKE? OR display_name LIKE?", "%#{search_user}%", "%#{search_user}%")
  end

  # ゲストユーザーのログイン情報
  def self.guest
    find_or_create_by!(display_name: "ゲストユーザー", name: "guestuser", telephone_number: "00000000000", email: "guest@example.com") do |guest_user|
      guest_user.password = SecureRandom.urlsafe_base64
    end
  end

  # フォローする（マッチングする）
  def follow(user_id)
    matchings.create(following_id: user_id)
  end

  # フォローを外す（マッチングを解除する）
  def unfollow(user_id)
    matchings.find_by(following_id: user_id).destroy
  end

  # フォロー（マッチング）判定
  def following?(user)
    followings.include?(user)
  end

  # フォロー（マッチング）通知の作成
  def create_notification_follow!(current_user)
    temp = Notification.where(["sender_id = ? and receiver_id = ? and action = ?", current_user.id, id, "follow"])
    if temp.blank?
      notification = current_user.active_notifications.new(receiver_id: id, action: "follow")
      notification.save if notification.valid?
    end
  end
end
