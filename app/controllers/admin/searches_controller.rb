class Admin::SearchesController < ApplicationController
  # キーワード検索用
  def search_post
    @search_word = params[:search_word]
    @posts = Post.search_word(params[:search_word]).page(params[:page])
    render "/admin/searches/post_result"
  end
  
  # ユーザー検索用
  def search_user
    @search_user = params[:search_user]
    @users = User.search_user(params[:search_user]).page(params[:page])
    render "/admin/searches/user_result"
  end
end
