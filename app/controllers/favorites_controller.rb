class FavoritesController < ApplicationController
    def create
     @book = Book.find(params[:book_id])
     favorite = current_user.favorites.new(book_id: @book.id)
     favorite.save
     render 'favorite.js.erb' 
    end
    
    def destroy
      @book = Book.find(params[:book_id])
      favorite = current_user.favorites.find_by(book_id: @book.id)
      #現在ログインしているユーザのFavoritの中でbook_idとbook.idが一致するもの取得
      favorite.destroy
      render 'favorite.js.erb' 
    end
    
    def follows
    user = User.find(params[:id])
    @users = user.followings
    end

    def followers
    user = User.find(params[:id])
    @users = user.followers
    end
end
