class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :phone
      t.string :twilio_number
      t.string :username

      t.timestamps null: false
    end
  end
end
