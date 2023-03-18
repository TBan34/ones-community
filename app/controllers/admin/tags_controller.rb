class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.page(params[:page])
  end

  def destroy
    tag = Tag.find(params[:id])
    if tag.destroy
      redirect_to request.referer, danger: "タグを削除しました"
    end
  end
end
