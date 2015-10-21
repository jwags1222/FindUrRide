
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
    house_requested = House.where(street_address: message_body)

    #SMSLogger.log_text_message from_number, message_body

    twilio_sid = 'AC06d72653ea2dca08e960c186cd893355'
    twilio_auth_token = '0e3877f28f5c03ffe0bfa6bd4e9f8840'
    twilio_phone_number = "4123451223"

    #client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    #message = client.messages.create from: '4123451223', to: '4124273378', body: 'We can now text. Its hardwired to your number right now but it works.  Call this number too'

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_auth_token

    if message_body.downcase == 'problem'

      @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => from_number, :body => " \n\nWe greatly appreciate you taking the time to give us your feedback. Although very painful to hear that you are not completely satisfied, it's feedback like yours that makes us better. You will be contacted shortly by a manager to rectify any issues or concerns. We value you as a customer and will do whatever it takes to make sure you are completely satisfied!")

    elsif car_requested.any?

      if(car_requested.last.dealership_id)
        dealership = Dealership.find(car_requested.last.dealership_id)
      end
      @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => from_number, :body => " \n\nHello from #{dealership.name}!! \n\nThank you for your interest in the #{car_requested.last.year}, #{car_requested.last.make} #{car_requested.last.model}. Follow this link for details and special pricing #{car_requested.last.link}.")
      @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => '4124273378', :body => " \n\nAnother lead from LeadFeed!  \n\n#{from_number} texted us about the #{car_requested.last.year},  #{car_requested.last.make} #{car_requested.last.model}. You will receive an email update with all of your leads at the end of the day.  \n\nThank you for your business")
    
    elsif house_requested.any?

    @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => from_number, :body => " \n\nHello from Coldwell Banker \n\nThank you for your interest in #{house_requested.last.street_address}. Please click on this link to see a price, estimated payment and all other details on this house. #{house_requested.last.link}. \n\n")
    @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => '4124273378', :body => " \n\nAnother lead from LeadFeed!  \n\n#{from_number} texted us about #{house_requested.last.street_address}. You will receive an email update with all of your leads at the end of the day.  \n\nThank you for your business!")
     

    #elsif message_body == "HELP" || message_body == "Help"
    
        #@twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => from_number, :body => " \n\nHello from Used Car World!! \n\nSorry that you are having trouble. Someone will be reaching out to you shortly.")
        #@twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => '4124273378', :body => " \n\nAnother lead from LeadFeed!  \n\nA prospect with the number #{from_number} is on your lot and texted us about a car. But they are having trouble and they would like for some additional help. Could be a hot lead if you call them now!")
    
    else
    
        @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => from_number, :body => " \n\nHello from Used Car World!! \n\nOoops! We're sorry but your text didn't match any of our cars.  #{message_body} was the text that we recieved.  Please check to make sure that there are no extra spaces in your text and that the numbers are correct.  Text HELP if you would like additional help.")
        @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => '4124273378', :body => " \n\nAnother lead from LeadFeed!  \n\nA prospect with the number #{from_number} is on your lot and and texted us about a car but what they sent us doesnt match our records.  Usually this is because somone fat fingered a number or added a space.  Please reach out when you can.\n\nAs always, thank you for your business!")
    end 


    # redirect_to root_path

  end 
end