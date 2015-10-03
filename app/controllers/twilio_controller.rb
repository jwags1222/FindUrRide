
require 'twilio-ruby'
 
class TwilioController < ApplicationController
  include Webhookable
 
  after_filter :set_header
 
  skip_before_action :verify_authenticity_token
 
  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hey there Ray, We have integrated voice in our application. We can also reach out with Voice. You are still very gay. ', :voice => 'alice'
    end
 
    render_twiml response
  end

  def text

    message_body = params["Body"]
    from_number = params["From"]

    car_requested = Car.where(stockid: message_body)

    #SMSLogger.log_text_message from_number, message_body

    twilio_sid = 'AC06d72653ea2dca08e960c186cd893355'
    twilio_auth_token = '0e3877f28f5c03ffe0bfa6bd4e9f8840'
    twilio_phone_number = "4123451223"

    #client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    #message = client.messages.create from: '4123451223', to: '4124273378', body: 'We can now text. Its hardwired to your number right now but it works.  Call this number too'

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_auth_token

    @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => from_number, :body => "Hello from Used Car World! Thank you for your interest in the #{car_requested.last.year}, #{car_requested.last.make} . Please see this link with all of the information you could need including price #{car_requested.last.link}. Also feel free to use this link if you'd like to get preapproved: https://www.linkedin.com/pub/jayson-hobbs/3/713/8b9")
    @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => '4124273378', :body => "Another lead from LeadFeed!  #{from_number} texted us about the #{car_requested.last.year},  #{car_requested.last.make} #{car_requested.last.model}. You will receive an email update with all of your leads at the end of the day.  Thank you for your business")

    redirect_to root_path, notice: 'Your SMS has been sent'

  end 
end