class RelationshipsController < ApplicationController
  
  def create
    current_user.follow(params[:user_id])
    #ログインしているユーザがフォローするなら
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    #ログインユーザがフォローを外す
    redirect_to request.referer  
  end
  
  def followings
    @user = User.find(params[:user_id])
    @relationships = Relationship.all
  end
  # フォロワー一覧
  def followers
    @user = User.find(params[:user_id])
  end
  
end