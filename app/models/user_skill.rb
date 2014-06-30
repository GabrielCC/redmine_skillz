class UserSkill < ActiveRecord::Base
  unloadable
  validates_presence_of :skill_id, :user_id, :skill_level_id
  belongs_to :skill
  belongs_to :user
  belongs_to :skill_level
end
