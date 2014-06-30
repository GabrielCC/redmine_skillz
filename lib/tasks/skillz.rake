namespace :redmine do
  namespace :skillz do
    desc "import skill names from file"
    task :import_skill_names => :environment do |task, args|
      file = File.expand_path(File.dirname(__FILE__)) + "/../../data/SkillZ.csv"
      skill_names = File.open(file, &:readline)
      skill_names = skill_names.split(',')
      skill_names.delete_at(1)
      skill_names.delete_at(0)
      imported_skill_names = []
      skill_names.map! { |skill_name|
        skill_name.gsub!('"', '')
        imported_skill_names << Skill.new(:name => skill_name)
      }
      Skill.import imported_skill_names
      puts Skill.count
    end

    desc "import user skills from file"
    task :import_skills => :environment do |task, args|
      file = File.expand_path(File.dirname(__FILE__)) + "/../../data/SkillZ.csv"
      skill_names = File.open(file, &:readline)
      skill_names = skill_names.split(',')
      skill_names.delete_at(1)
      skill_names.delete_at(0)
      skill_names.map! { |skill_name|
        skill_name.gsub!('"', '')
      }
      skill_entries = {}
      Skill.all.each { |skill|
        skill_entries[skill.name] = skill 
      }

      skill_levels = {}
      SkillLevel.all.each { |skill_level| 
        skill_levels[skill_level.name] = skill_level 
      }

      ## remove the last field (altele)
      skill_names.pop
      CSV.foreach(file, :headers => true) do |row|
        massive_inserts = []
        user = get_user(row[1])
        skill_names.each_with_index { |skill_name, i|

          user_skill = UserSkill.new
          skill_level_name = row[i+2]
          user_skill.skill = skill_entries[skill_name]
          user_skill.user = user
          unless skill_levels.has_key?(skill_level_name)
             skill_level_entry = SkillLevel.find_or_initialize_by_name(skill_level_name)
             skill_level_entry.save
             skill_levels[skill_level_name] = skill_level_entry
          end
          user_skill.skill_level = skill_levels[skill_level_name]
          massive_inserts << user_skill
        }
        UserSkill.import massive_inserts
      end
    end

    def get_user(username)
      email = "#{username}@zitec.ro"
      user = User.find_or_initialize_by_login(username)
      if user.new_record?
        user.firstname = user.lastname = username
        user.mail = email
        user.save
      end
      user
    end
  end
end
