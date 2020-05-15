class Api::CommentsController < ApplicationController
  def index
    # ルーティングでの設定によりparamsの中にgroup_idというキーでグループのidが入るので、これを元にDBからグループを取得する
    group = Group.find(params[:group_id])
    # ajaxで送られてくる最後のメッセージのid番号を変数に代入
    last_comment_id = params[:id].to_i
    # 取得したグループでのメッセージ達から、idがlast_comment_idよりも新しい(大きい)メッセージ達のみを取得
    @comments = group.comments.includes(:user).where("id > ?", last_comment_id)
  end
end