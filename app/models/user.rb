class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_and_belongs_to_many :chapters
  has_many :subscriptions
  has_many :books, through: :subscriptions
  attr_writer :login
  def login
    @login || self.name || self.email
  end
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
      
    end
    
  end  
  def get_books
    @pieces = []
    chapters = self.chapters.where(is_first: true)
    chapters.each do |chapter|
        @pieces.push(chapter.book)
    end
    return @pieces
  end
  
end
