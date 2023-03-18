class Admin::SearchesController < ApplicationController
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

  # ユーザー検索用
  def search_user
    @search_user = params[:search_user]
    @users = User.search_user(params[:search_user]).page(params[:page])
    render "/admin/searches/user_result"
  end
end
