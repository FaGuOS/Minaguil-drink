class Post < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :review
    validates :policy_agreement
    validates :yes
  end

  #validate :policy_agreement_must_be_accepted # ポリシー同意のバリデーションを追加

  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :yeses, dependent: :destroy
  has_many :bookmarks
  has_many :bookmarking_users, through: :bookmarks, source: :user

  attr_accessor :policy_agreement

  def self.looks(search, word)
    if search == "exact_match"
      where("title LIKE ?", "#{word}")
    elsif search == "forward_match"
      where("title LIKE ?", "#{word}%")
    elsif search == "backward_match"
      where("title LIKE ?", "%#{word}")
    elsif search == "partial_match"
      where("title LIKE ?", "%#{word}%")
    else
      @user = User.all
    end
  end

  #private

  #def policy_agreement_must_be_accepted
    #errors.add(:policy_agreement, "ポリシーを確認し同意のチェックを行ってください") unless policy_agreement == '1'
  #end
end
