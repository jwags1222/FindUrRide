
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

    @car_requested = Car.where(stockid: message_body).last
    house_requested = House.where(street_address: message_body)

    client = Bitly.client

    #SMSLogger.log_text_message from_number, message_body

    twilio_sid = 'AC06d72653ea2dca08e960c186cd893355'
    twilio_auth_token = '0e3877f28f5c03ffe0bfa6bd4e9f8840'
    twilio_phone_number = "4123451223"

    #client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    #message = client.messages.create from: '4123451223', to: '4124273378', body: 'We can now text. Its hardwired to your number right now but it works.  Call this number too'

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_auth_token

    if message_body.downcase == 'problem'

      @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => from_number, :body => " \n\nWe greatly appreciate you taking the time to give us your feedback. Although very painful to hear that you are not completely satisfied, it's feedback like yours that makes us better. You will be contacted shortly by a manager to rectify any issues or concerns. We value you as a customer and will do whatever it takes to make sure you are completely satisfied!")
      @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => '4123035888', :body => " \n\n Unfortunately a customer is not completely satisfied! \n\n No worries, thanks to FYRE it is not too late! Contact #{from_number} asap to rectify any issues or concerns.")

    elsif message_body.downcase == 'service'

      @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => from_number, :body => " \n\nThank you for contacting the service department at Day Apollo Subaru!\n\n Please follow this link to take advantage of our current specials!  http://bit.ly/1jDgkFe \n\n Also, don't forget to schedule your next visit, with our easy scheduling process! http://bit.ly/1M85nSn")
      @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => '4123035888', :body => " \n\nAnother service customer has taken advantage of FYRE! \n\n #{from_number} requested your service specials and can now easily schedule their service visit \n\n       A complete list of all customers using this tool will be emailed every Monday am!")

    elsif @car_requested.present?

      if(@car_requested.dealership_id)
        dealership = Dealership.find(@car_requested.dealership_id)
      end
      @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => from_number, :body => " \n\nHello from #{dealership.name}!! \n\nThank you for your interest in the #{@car_requested.year}, #{@car_requested.make} #{@car_requested.model}. Follow this link for details and special pricing #{@car_requested.link2}.")
      @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => dealership.phonenumber, :body => " \n\nAnother lead from Fyre!  \n\n#{from_number} texted us about the #{@car_requested.year},  #{@car_requested.make} #{@car_requested.model}. You will receive an email update with all of your leads at the end of the day.  \n\nThank you for your business")
    
    elsif house_requested.any?

    @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => from_number, :body => " \n\nHello from Coldwell Banker \n\nThank you for your interest in #{house_requested.last.street_address}. Please click on this link to see a price, estimated payment and all other details on this house. #{house_requested.last.link}. \n\n")
    @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => '4124273378', :body => " \n\nAnother lead from Fyre!  \n\n#{from_number} texted us about #{house_requested.last.street_address}. You will receive an email update with all of your leads at the end of the day.  \n\nThank you for your business!")

    
    else
    
        @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => from_number, :body => " \n\nHello from Used Car World!! \n\nOoops! We're sorry but your text didn't match any of our cars.  #{message_body} was the text that we recieved.  Please check to make sure that there are no extra spaces in your text and that the numbers are correct.  Text HELP if you would like additional help.")
        @twilio_client.account.messages.create(:from => "+1#{twilio_phone_number}", :to => '4124273378', :body => " \n\nAnother lead from Fyre!  \n\nA prospect with the number #{from_number} is on your lot and and texted us about a car but what they sent us doesnt match our records.  Usually this is because somone fat fingered a number or added a space.  Please reach out when you can.\n\nAs always, thank you for your business!")
    end


    render :nothing => true
    # redirect_to root_path

  end 
end