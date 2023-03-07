class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy

  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  #has_many :xxx, class_name: "モデル名", foreign_key: "○○_id", dependent: :destroy
  #フォロー
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :follower, source: :followed
  
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :followed, source: :follower
   #has_many :yyy, through: :xxx, source: :zzz
  
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum:50}
  
  def get_profile_image(width, height)
    unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end


 
  def follow(user)
    follower.create(followed_id: user_id)
  end

  def unfollow(user)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
  
end
