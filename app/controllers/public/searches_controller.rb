class Public::SearchesController < ApplicationController
  # キーワード検索用
  def search
    @search_word = params[:search_word]
    @posts = Post.search_word(params[:search_word]).page(params[:page])
    render "/public/searches/search_result"
  end
end
