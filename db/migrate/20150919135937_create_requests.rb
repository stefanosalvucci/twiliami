class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :request_phone
      t.string :request_twilio_number
      t.string :request_username

      t.references :space

      t.timestamps null: false
    end
  end
end
