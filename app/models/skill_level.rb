class SkillLevel < ActiveRecord::Base
  unloadable
  validates :name, uniqueness: true, presence: true
  belongs_to :user_skill
end
