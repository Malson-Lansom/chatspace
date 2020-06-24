class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :group_users
         has_many :group, through: :group_users

  # usermodel(devise)のvalidationを実装する（問題１）
  # 問題１のメモ
  # /^[0-9]+$/           全て半角数値
  # /^[0-9０-９]+$/       全て全角数値
  # /^[a-zA-Z0-9]+$/      全て半角アルファベット（大文字/小文字/数字)
  # /^\d{10}$/            電話番号（ハイフンなし10桁）
  # /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/    email
    # 以下の３分割
    #   /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+
    #     @[a-zA-Z0-9-]+
    #     (?:\.[a-zA-Z0-9-]+)*$/

  validates :name, presence: true, uniqueness: true, length: { in: 8..12 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  VALID_PASSWORD_REGEX = /(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}/i
  validates :encrypted_password, presence: true, format: { with: VALID_PASSWORD_REGEX }

end


