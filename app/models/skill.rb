class Skill < ActiveRecord::Base
  unloadable
  has_many :user
  has_many :user, :through => :user_skill
  validates :name, uniqueness: true, presence: true

end
