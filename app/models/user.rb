class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # Deviseのモジュールをインクルード
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :yeses, dependent: :destroy
  has_many :bookmarks
  has_many :bookmarked_posts, through: :bookmarks, source: :post
  

  # バリデーション
  validates :user_name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :personal_id, presence: true, uniqueness: true

  # コールバック
  before_validation :generate_unique_personal_id, on: :create

  # 非表示用のアクション
  def hidden_posts
    HiddenPost.where(user_id: self.id).pluck(:post_id)
  end

  # 検索用のアクション
  def self.looks(search, word)
    if search == "exact_match"
      where("user_name LIKE ?", "#{word}")
    elsif search == "forward_match"
      where("user_name LIKE ?", "#{word}%")
    elsif search == "backward_match"
      where("user_name LIKE ?", "%#{word}")
    elsif search == "partial_match"
      where("user_name LIKE ?", "%#{word}%")
    else
      @user = User.all
    end
  end

  def admin?
    self.admin
  end

  private

  def generate_unique_personal_id
    self.personal_id ||= loop do
      random_id = SecureRandom.random_number(1_000_000)
      break random_id unless self.class.exists?(personal_id: random_id)
    end
  end
end
