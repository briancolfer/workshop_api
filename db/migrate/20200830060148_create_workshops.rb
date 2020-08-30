class CreateWorkshops < ActiveRecord::Migration[6.0]
  def change
    create_table :workshops do |t|
      t.string :workshop_name
      t.text :description
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
