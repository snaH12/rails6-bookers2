class RelationshipsController < ApplicationController
  
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    #ログインしているユーザがフォローするなら
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    #ログインユーザがフォローを外す
    redirect_to request.referer  
  end
  
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings
  end
  # フォロワー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end
  
end