class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
  has_many :collaborator_users, through: :collaborators, source: :user

  after_initialize :initialize_role
  
  private
  
  def initialize_role
    self.private = false if self.private.nil?
  end
end
