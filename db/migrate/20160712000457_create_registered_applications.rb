class CreateRegisteredApplications < ActiveRecord::Migration
  def change
    create_table :registered_applications do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.references :user, null: false

      t.timestamps null: false
    end
    add_index :registered_applications, [:user_id, :url], unique: true
    add_index :registered_applications, [:user_id, :name], unique: true
    add_foreign_key :registered_applications, :user_id
  end
end
