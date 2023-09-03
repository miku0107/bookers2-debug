class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def get_image
    if image.attached?
       image
    else
      'no_image.jpg'
    end  
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"  
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    
    else
      @book = Book.all
    end    
  end
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
