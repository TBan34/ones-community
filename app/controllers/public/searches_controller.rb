class Public::SearchesController < ApplicationController
  
  def search
    @search_word = params[:search_word]
    @posts = Post.search_word(params[:search_word])
    render "/public/searches/search_result"
  end
  
end
