class CreateEvents < ActiveRecord::Migration
  def change
	create_table :events do |t|
	  t.string :name, null: false
	  t.references :registered_application, null: false

	  t.timestamps null: false
    end
    
    add_foreign_key :events, :registered_application_id
  end
end
