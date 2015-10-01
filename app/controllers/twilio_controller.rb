
require 'twilio-ruby'
 
class TwilioController < ApplicationController
  include Webhookable
 
  after_filter :set_header
 
  skip_before_action :verify_authenticity_token
 
  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hey there Ray, We have integrated voice in our application.', :voice => 'alice'
         r.Play 'https://www.youtube.com/watch?v=04KQydlJ-qc'
    end
 
    render_twiml response
  end
end