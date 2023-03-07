class Chat < ApplicationRecord
    belongs_to :user
    belongs_to :room
    
    validates :message, length: { minimum: 2, maximum: 140 }
end
