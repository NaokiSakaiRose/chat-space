class UsersController < ApplicationController
  def index
    return nil if params[:keyword] == ""
    @users = User.where(['username LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
