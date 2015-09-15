require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable

  layout nil


  after_filter :set_header, only: [:voice]
  skip_before_action :verify_authenticity_token

  def bob
    account_sid = 'ACc4f9ba50ae20f1fc3c1db71f32e86968'
    auth_token = '656974d564a1d3bccfe32c58358b722c'
    # This application sid will play a Welcome Message.
    demo_app_sid = 'APabe7650f654fc34655fc81ae71caa3ff'
    capability = Twilio::Util::Capability.new account_sid, auth_token
    capability.allow_client_outgoing demo_app_sid
    @token = capability.generate
  end


  def alice
    account_sid = 'ACc4f9ba50ae20f1fc3c1db71f32e86968'
    auth_token = '656974d564a1d3bccfe32c58358b722c'
    capability = Twilio::Util::Capability.new account_sid, auth_token
    # Create an application sid at twilio.com/user/account/apps and use it here
    capability.allow_client_outgoing "APe10da3657e9c4d5ac5d8450ebb5e9c7b"
    capability.allow_client_incoming "alice"
    @token = capability.generate
  end


  def voice_alice
    response = Twilio::TwiML::Response.new do |r|
      # Should be your Twilio Number or a verified Caller ID
      r.Dial :callerId => '+390457860875' do |d|
        d.Client 'alice'
      end
    end
    render_twiml response
  end
end