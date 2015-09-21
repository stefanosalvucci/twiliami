class CreateAvailableTwilioNumbers < ActiveRecord::Migration
  def change
    create_table :available_twilio_numbers do |t|
      t.string :number
      t.string :sid
      t.string :status

      t.references :space
      t.references :request

      t.timestamps null: false
    end
  end
end
