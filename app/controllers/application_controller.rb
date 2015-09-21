class ApplicationController < ActionController::Base
  require 'rubygems'
  require 'twilio-ruby'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def update_twilio_number_voice_url object
    account_sid = 'ACc4f9ba50ae20f1fc3c1db71f32e86968'
    auth_token = '656974d564a1d3bccfe32c58358b722c'

    @client = Twilio::REST::Client.new account_sid, auth_token

    begin
      available_number = AvailableTwilioNumber.where(status: 'released').first
      sid = available_number.sid
    rescue Exception
      raise 'The only number we have is already assigned'
    end
    @twilio_number = @client.account.incoming_phone_numbers.get(sid)
    @twilio_number.update(
      :VoiceUrl => url_for(
        controller: object.class.to_s.tableize,
        action: :forward,
        id: object.id,
        format: :xml
      )
    )
    AvailableTwilioNumber.where(status: 'released').first.update_column(:status, 'busy')
    case object
    when Request
      available_number.request = object
      available_number.save
    when Space
      available_number.space = object
      available_number.save
    end

    available_number.number
  end

end
