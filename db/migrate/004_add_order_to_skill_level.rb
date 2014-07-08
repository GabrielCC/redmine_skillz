class AddOrderToSkillLevel < ActiveRecord::Migration
  def change
   	skill_level = {"cunostinte solide" => 4,
   	 "cunostinte medii" => 3, 
   	 "cunostinte de baza" => 2,
   	 "cunostinte teoretice" => 1, 
   	 "nu am cunostinte" => 0 
   	}
   	change_table :skill_levels do |t|
	  t.integer :order, default: 0
	end
	skill_level.each_pair { |name, val|
		entry = SkillLevel.find_or_initialize_by_name(name)
		entry.order = val
		entry.save  
	}
  end
end
