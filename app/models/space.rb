class Space < ActiveRecord::Base
  has_many :requests, dependent: :destroy
  has_one :available_twilio_number

end
