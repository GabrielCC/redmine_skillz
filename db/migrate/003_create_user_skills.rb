class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|

      t.references :user

      t.references :skill

      t.references :skill_level


    end

    add_index :user_skills, :user_id

    add_index :user_skills, :skill_id

  end
end
