
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
  end    
end
