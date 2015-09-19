class ApplicationController < ActionController::Base
  require 'rubygems'
  require 'twilio-ruby'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def create_number_from_twilio object
    account_sid = 'ACc4f9ba50ae20f1fc3c1db71f32e86968'
    auth_token = '656974d564a1d3bccfe32c58358b722c'

    @client = Twilio::REST::Client.new account_sid, auth_token

    @numbers = @client.account.available_phone_numbers.get('IT').local.list()

    # Purchase the number
    @number = @numbers[0].phone_number
    @client.account.incoming_phone_numbers.create(
      :phone_number => @number,
      :VoiceUrl => url_for(
        controller: object.class.to_s.tableize,
        action: :forward,
        id: object.id,
        format: :xml
      )
    )
    @number
  end

end
