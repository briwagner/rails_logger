class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :employer_id, null: false
      t.string :description, null: false
      t.datetime :time_in, null: false
      t.datetime :time_out

      t.timestamps null: false
    end
  end
end
