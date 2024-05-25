class Comment < ApplicationRecord
  belongs_to :post# 1つのコメントは1つのポストに紐付く
  belongs_to :user
  
  validates :comment_1, :comment_2, presence: true

  def comments_list  # コメントの一覧を呼び出すメソッド
    Comment.all
  end
end
