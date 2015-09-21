class Request < ActiveRecord::Base
  belongs_to :space
  has_one :available_twilio_number

end
