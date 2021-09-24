class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :books, dependent: :destroy
  attachment :profile_image, destroy: false

  validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def already_favorite?(book)
    favorites.exists?(book_id: book.id)
  end


end
