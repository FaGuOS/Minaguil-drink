class Post < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :review
    validates :policy_agreement
    validates :yes
    validates :rate, inclusion: { in: 1..5, message: "must be between 1 and 5" }
  end

  has_one_attached :image, dependent: :destroy

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :yeses, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarking_users, through: :bookmarks, source: :user
  has_many :views, dependent: :destroy
  has_many :viewers, through: :views, source: :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  attr_accessor :policy_agreement

  def self.looks(search, word)
    case search
    when "exact_match"
      where("title LIKE ?", "#{word}")
    when "forward_match"
      where("title LIKE ?", "#{word}%")
    when "backward_match"
      where("title LIKE ?", "%#{word}")
    when "partial_match"
      where("title LIKE ?", "%#{word}%")
    else
      @user = User.all
    end
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  #private

  #def policy_agreement_must_be_accepted
    #errors.add(:policy_agreement, "ポリシーを確認し同意のチェックを行ってください") unless policy_agreement == '1'
  #end
end
