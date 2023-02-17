class Post < ApplicationRecord
  
  belongs_to :user
  has_many :rooms
  has_many :notifications, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  
  # 投稿にイメージ画像を添付
  has_one_attached :image
  
  validates :title, presence: true
  validates :time, presence: true
  validates :place, presence: true
  validates :belonging, presence: true
  validates :body, presence: true
  
  # 投稿の公開・非公開を設定
  enum status: { public: 0, private: 1 }, _prefix: true
  
  # デフォルト画像の設定、画像サイズの指定方法
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_square.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-sports-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  # いいねをしたか確認
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # キーワード検索（部分一致）
  def self.search_word(search_word)
    @post = Post.where("title LIKE?", "%#{search_word}%")
  end
  
  # いいね通知の作成（投稿に対して他のユーザーから初めていいねされた場合）
  def create_notification_favorite!(current_user)
    temp_favorite = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, "favorite"])
    if temp_favorite.blank?
      notification = current_user.active_notifications.new(post_id: id, visited_id: user_id, action: "favorite")
      notification.checked = false unless notification.visitor_id != notification.visited_id
      notification.save if notification.valid?
    end
  end
  
  # コメント通知の作成（投稿に対して他のユーザーからコメントがあった場合）
  def create_notification_comment!(current_user, comment_id)
    temp_users = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_users.each do |temp_user|
      save_notification_comment!(current_user, comment_id, temp_user["user_id"])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_users.blank?
  end
  
  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(post_id: id, comment_id: comment_id, visited_id: visited_id, action: "comment")
    notification.checked = false unless notification.visitor_id != notification.visited_id
    notification.save if notification.valid?
  end
  
end
