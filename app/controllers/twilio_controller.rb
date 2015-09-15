require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable

  layout nil


  after_filter :set_header, only: [:voice]
  skip_before_action :verify_authenticity_token

  def client
    @client_name = params[:client]
    if @client_name.nil?
        @client_name = 'jenny'
    end
    account_sid = 'ACc4f9ba50ae20f1fc3c1db71f32e86968'
    auth_token = '656974d564a1d3bccfe32c58358b722c'
    capability = Twilio::Util::Capability.new account_sid, auth_token
    # Create an application sid at twilio.com/user/account/apps and use it here
    capability.allow_client_outgoing "APe10da3657e9c4d5ac5d8450ebb5e9c7b"
    capability.allow_client_incoming @client_name
    @token = capability.generate
  end

  def voice
    caller_id = "+390457860875"

    number = params[:PhoneNumber]
    response = Twilio::TwiML::Response.new do |r|
        # Should be your Twilio Number or a verified Caller ID
        r.Dial :callerId => caller_id do |d|
            # Test to see if the PhoneNumber is a number, or a Client ID. In
            # this case, we detect a Client ID by the presence of non-numbers
            # in the PhoneNumber parameter.
            if /^[\d\+\-\(\) ]+$/.match(number)
                d.Number(CGI::escapeHTML number)
            else
                d.Client number
            end
        end
    end
    render_twiml response
  end
end