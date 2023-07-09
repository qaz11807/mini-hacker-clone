class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  include Users::Authenciated

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :votes, dependent: :destroy
end
