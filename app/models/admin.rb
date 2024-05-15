class Admin < ApplicationRecord
  # Deviseの設定やその他のロジックがここに含まれる
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
