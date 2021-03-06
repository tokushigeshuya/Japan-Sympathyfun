class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
   has_one_attached :profile_image
    has_many :post, dependent: :destroy

    has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

    has_many :followings, through: :relationships, source: :followed
    has_many :followers, through: :reverse_of_relationships, source: :follower

    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy

    validates :name, presence: true

    def active_for_authentication?
      super && (is_deleted == false)
    end

    def follow(user_id)
      relationships.create(followed_id: user_id)
    end

    def unfollow(user_id)
      relationships.find_by(followed_id: user_id).destroy
    end

    def following?(user_id)
      followings.include?(user_id)
    end

  def get_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end
end
