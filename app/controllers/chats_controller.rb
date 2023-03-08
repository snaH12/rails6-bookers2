class ChatsController < ApplicationController
 #アクション前にuser同士が相互フォローしているか判定
 before_action :reject_non_related, only: [:show]
  
  def show
  #相手のUser情報を取得
   @user = User.find(params[:id])
  #pluckメソッド：指定したカラムのレコードの配列を取得
   rooms = current_user.user_rooms.pluck(:room_id)
  #user_idが相手のid、room_idが属するroomとなるuser_roomsテーブルのレコードを取得して、user_room変数に格納
  #これによって共通のroom_idが存在していれば、その共通のroom_idと相手のuser_idがuser_room変数に格納される。存在しなければ、nilになる。
   user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

  #user_roomでルームを取得できなかった（まだ存在しない）場合の処理  
   unless user_rooms.nil?
     #user_roomに紐づくroomsテーブルのレコードをroomに格納
    @room = user_rooms.room
   else
     #新しくroomを作成
     @room = Room.new
     @room.save
      #roomのidを使ってuser_roomのレコードを2人分作る（共通のroom_idを作る）
      #（相手の）@user.idをuser_idとして、room.idをroom_idとして、UserRoomモデルのがラムに保存
     UserRoom.create(user_id: current_user.id, room_id: @room.id)
      #current_user.idをuser_idとして、room.idをroom_idとして、UserRoomモデルのカラムに保存
     UserRoom.create(user_id: @user.id, room_id: @room.id)
   end
    @chats = @room.chats
   #form_withでチャットを送信する際に必要な空のインスタンス
    @chat = Chat.new(room_id: @room.id)
  end
 
  def create
    @chat = current_user.chats.new(chat_params)
    render :validater unless @chat.save
  end
  
  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
  
  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to books_path
    end
  end

end
