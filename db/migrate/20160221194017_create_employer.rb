class CreateEmployer < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :name, null: false
      t.integer :rate

      t.timestamps
    end
  end
end
