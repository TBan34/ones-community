class Admin::SearchesController < ApplicationController
  
  def search
    @search_word = params[:search_word]
    @posts = Post.search_word(params[:search_word])
    render "/admin/searches/search_result"
  end
  
end
