class CommentsController < ApplicationController
  before_action :set_group

  def index
    @comment = Comment.new
    @comments = @group.comments.includes(:user)
  end

  def create
    @comment = @group.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.json
      end
    else
      @comments = @group.comments.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end

    respond_to do |format|
      format.html { redirect_to group_comments_path, notice: "メッセージを送信しました" }
      format.json
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
