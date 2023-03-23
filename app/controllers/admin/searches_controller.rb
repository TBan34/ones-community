class Admin::SearchesController < ApplicationController
  # ユーザー検索用
  def search_user
    @search_user = params[:search_user]
    @users = User.search_user(params[:search_user]).page(params[:page])
    render "/admin/searches/user_result"
  end
  
  # キーワード検索用（複数ワード対応）
  def search_post
    @search_word = params[:search_word]
    @posts = []
    @search_word.split(/[[:blank:]]+/).each do |search_word|
      next if search_word == ""
      @posts += Post.search_word(search_word)
    end
    @posts.uniq!
    @posts = Kaminari.paginate_array(@posts).page(params[:page])
    render "/admin/searches/post_result"
  end
  
  # ルーム検索用（ユーザー名or投稿名）
  def search_room
    @range = params[:range]
    @search_room = params[:search_room]
    
    if @range == "ユーザー"
      # 検索にヒットした全てのユーザーのID（投稿者ID）
      # 投稿者の全ての投稿のID
      # 上記投稿IDを持つ全てのルームを抽出
      user_ids = User.where("display_name LIKE ?", "%#{@search_room}%").pluck(:id)
      post_ids = Post.where(user_id: user_ids).pluck(:id)
      @rooms = Room.where(post_id: post_ids).page(params[:page])
      render "admin/searches/room_result"
    else
      # 検索にヒットした全ての投稿のID
      # 上記投稿IDを持つ全てのルームを抽出
      post_ids = Post.where("title LIKE ?", "%#{@search_room}%").pluck(:id)
      @rooms = Room.where(post_id: post_ids).page(params[:page])
      render "admin/searches/room_result"
    end
  end
end
