class CreateJoinTablePersonWorkshop < ActiveRecord::Migration[6.0]
  def change
    create_join_table :people, :workshops do |t|
      # t.index [:person_id, :workshop_id]
      # t.index [:workshop_id, :person_id]
    end
  end
end
