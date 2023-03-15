class Post < ApplicationRecord
  MAX_POST_TAGS_COUNT = 5
    
  belongs_to :user
  has_many   :rooms,         dependent: :destroy
  has_many   :notifications, dependent: :destroy
  has_many   :favorites,     dependent: :destroy
  has_many   :comments,      dependent: :destroy
  has_many   :post_tags,     dependent: :destroy
  has_many   :tags,          through: :post_tags, dependent: :destroy

  has_one_attached :image

  validates :title,       presence: true
  validates :since_when,  presence: true
  validates :at_where,    presence: true
  validates :for_playing, presence: true
  validates :body,        presence: true

  # 投稿の公開・非公開を設定
  enum status: { public: 0, private: 1 }, _prefix: true

  # 投稿のタグ保存/更新
  def save_tags(tag_data)
    posting_tags = tag_data.split(/[[:blank:]]+/)
    if posting_tags.count > MAX_POST_TAGS_COUNT
      errors.add(:base, "タグの数は最大#{MAX_POST_TAGS_COUNT}個までです")
      return false
    end
    
    current_tags = self.tags.pluck(:name)
    
    old_tags = current_tags - posting_tags
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
    
    new_tags = posting_tags - current_tags
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
    
    true
  end

  # 投稿データからステータスが公開でアクティブなユーザを取得、タグ検索用にtagsも結合
  def self.list(tag_id, page, user_id)
    posts = status_public.left_joins(:user).where(user: { is_deleted: false })

    if tag_id.present?
      posts = posts.left_joins(:tags).where(tags: { id: tag_id })
    end
    if user_id.present?
      posts = posts.where(user_id: user_id)
    end

    posts = posts.order(created_at: :desc).page(page)
    return posts
  end

  # デフォルト画像の設定、サイズの指定
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/no_image_square.jpeg")
      image.attach(io: File.open(file_path), filename: "default-sports-image.jpg", content_type: "image/jpeg")
    end
    image.variant(resize: "#{width}x#{height}!").processed
  end

  # いいねされているか確認
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # キーワード検索（部分一致）
  def self.search_word(search_word)
    @post = Post.where("title LIKE? OR body LIKE? OR at_where LIKE?", 
    "%#{search_word}%", "%#{search_word}%", "%#{search_word}%")
  end

  # いいね通知の作成（投稿に対して自分以外のユーザーから初めていいねされた場合）
  def create_notification_favorite!(current_user)
    temp_favorite = Notification.where(["sender_id = ? and receiver_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, "favorite"])
    if temp_favorite.blank?
      notification = current_user.active_notifications.new(post_id: id, receiver_id: user_id, action: "favorite")
      notification.checked = false unless notification.sender_id != notification.receiver_id
      notification.save if notification.valid?
    end
  end

  # コメント通知の作成（投稿に対して自分以外のユーザーからコメントがあった場合）
  def create_notification_comment!(current_user, comment_id)
    temp_users = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_users.each do |temp_user|
      save_notification_comment!(current_user, comment_id, temp_user["user_id"])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_users.blank?
  end

  def save_notification_comment!(current_user, comment_id, receiver_id)
    notification = current_user.active_notifications.new(post_id: id, comment_id: comment_id, receiver_id: receiver_id, action: "comment")
    notification.checked = false unless notification.sender_id != notification.receiver_id
    notification.save if notification.valid?
  end
end
