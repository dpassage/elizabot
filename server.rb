require 'sinatra'
require 'twilio-ruby'

before do
#  content_type :txt
  @defeat = {rock: :scissors, paper: :rock, scissors: :paper}
  @throws = @defeat.keys
end

get '/throw/:type' do
  player_throw = params[:type].to_sym

  if !@throws.include?(player_throw)
    halt 403, "You must throw one of the following: #{@throws}"
  end

  computer_throw = @throws.sample

  if player_throw == computer_throw
    "You tied with the computer. Try again!"
  elsif computer_throw == @defeat[player_throw]
    "Niceley done; #{player_throw} beats #{computer_throw}!"
  else
    "Ouch; #{computer_throw} beats #{player_throw}. Better luck next time!"
  end
end

get '/sms-quickstart' do
    twiml = Twilio::TwiML::Response.new do |r|
        r.Message do |message|
        message.Body "Body"
        message.MediaUrl "https://demo.twilio.com/owl.png"
        message.MediaUrl "https://demo.twilio.com/logo.png"
        end
    end
    twiml.text
end

post '/sms-quickstart' do
  puts request
  "ack"
end
