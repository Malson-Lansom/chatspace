class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  # contentカラムが空の場合は保存しないというバリデーション
  # オプションでNOTNULL制約つけるが、クライアントサイドの動き
  # unless: :image? imageが空だった場合という条件式
  validates :content, presence: true, unless: :image?
  # ユーザーモデルのimageに画像URLを格納する=>userコントローラー編集
  mount_uploader :image, ImageUploader
end
