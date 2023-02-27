class Admin::CommentsController < ApplicationController
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
