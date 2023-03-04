class Relationship < ApplicationRecord
    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User"
    
    def follow?(user)
     follows.include?(user)
    end
end
