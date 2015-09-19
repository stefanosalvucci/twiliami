class CreateAvailableTwilioNumbers < ActiveRecord::Migration
  def change
    create_table :available_twilio_numbers do |t|
      t.string :number
      t.string :status

      t.timestamps null: false
    end
  end
end
