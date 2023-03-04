class Relationship < ApplicationRecord
    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User"
    
    #フォローする
    def follow(user_id)
    follower.create(followed_id: user_id)
    end
    
    #フォローを外す
    def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
    end
    
    def follow?(user)
     follows.include?(user)
    end
end
