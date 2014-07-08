
# Patches Redmine's Role dynamically.  Adds a relationship 
# Role +has_one+ to ResourceSetting
module UserPatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    # Same as typing in the class 
    base.class_eval do
      has_many :user_skill, dependent: :destroy
      has_many :skill, :through => :user_skill
    end

  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    def user_skills
      skills = user_skill.joins(:skill,:skill_level).includes(:skill,:skill_level).order('`order` DESC').order('skills_name ASC')
      skills
    end
  end    
end
