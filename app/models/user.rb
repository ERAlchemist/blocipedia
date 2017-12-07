class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable 
  has_many :wikis, dependent: :destroy
  has_many :collaborators
  has_many :collaborated_wikis, through: :collaborators, source: :wiki

  after_initialize :initialize_role
  
  enum role: [:standard, :premium, :admin]
  
  private
  
  def initialize_role
    self.role ||= :standard
  end
end
