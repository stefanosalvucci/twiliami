class AvailableTwilioNumber < ActiveRecord::Base

  belongs_to :space
  belongs_to :request

end
