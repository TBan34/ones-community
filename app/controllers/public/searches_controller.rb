class Public::SearchesController < ApplicationController
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
    render "/public/searches/post_result"
  end
  
  # ルーム検索用（ユーザー名or投稿名）
  def search_room
    @range = params[:range]
    @search_room = params[:search_room]
    
    if @range == "ユーザー"
      # 検索にヒットした全ユーザーのID、及びカレントユーザーを含む全ルームのIDを取得し、ルームを絞り込み
      user_ids = User.where("display_name LIKE ?", "%#{@search_room}%").pluck(:id)
      room_ids = UserRoom.where(user_id: current_user.id).pluck(:room_id)
      @post_user_room = UserRoom.where(user_id: user_ids, room_id: room_ids).page(params[:page])
      render "public/searches/room_result"
    else
      # 検索にヒットした全投稿、及び投稿のカレントユーザーを含む全ルームのIDを取得し、ルームを絞り込み
      posts = Post.where("title LIKE ?", "%#{@search_room}%")
      room_ids = UserRoom.where(user_id: current_user.id, room_id: posts.rooms.ids).pluck(:room_id)
      @post_user_room = UserRoom.where(user_id: posts.user_id, room_id: room_ids).page(params[:page])
      render "public/searches/room_result"
    end
  end
end
