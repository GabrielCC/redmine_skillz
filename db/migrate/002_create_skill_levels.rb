class CreateSkillLevels < ActiveRecord::Migration
  def change
    create_table :skill_levels do |t|

      t.string :name


    end

  end
end
