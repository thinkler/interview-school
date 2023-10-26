class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true

      t.time :start_time, null: false
      t.time :end_time, null: false
      t.integer :weekdays, array: true, default: [0, 0, 0, 0, 0, 0, 0], null: false

      t.timestamps
    end
  end
end
