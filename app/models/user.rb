class User < ApplicationRecord
  # Deviseのモジュールをインクルード
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :yeses, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_posts, through: :bookmarks, source: :post
  has_many :views, dependent: :destroy
  has_many :viewed_posts, through: :views, source: :post
  
  has_many :hidden_posts, dependent: :destroy
  has_many :hidden_posted_posts, through: :hidden_posts, source: :post

  # バリデーション
  validates :user_name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :personal_id, presence: true, uniqueness: true

  # コールバック
  before_validation :generate_unique_personal_id, on: :create
  
  # 非表示用のアクション
  def hidden_post_ids
    hidden_posts.pluck(:post_id)
  end

  # 管理者用のアクション
  after_initialize :set_default_admin, if: :new_record?

  def set_default_admin
    self.admin ||= false
  end

  # 検索用のアクション
  def self.looks(search, word)
    case search
    when "exact_match"
      where("user_name LIKE ?", "#{word}")
    when "forward_match"
      where("user_name LIKE ?", "#{word}%")
    when "backward_match"
      where("user_name LIKE ?", "%#{word}")
    when "partial_match"
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
