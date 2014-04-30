require 'sinatra'
require 'twilio-ruby'
require 'eliza'

elizabots = {}

post '/sms-quickstart' do
  inbound = params['Body']
  number = params['From']
  eliza = elizabots[number]

  if !eliza
    eliza = Eliza::Interpreter.new()
    elizabots[number] = eliza
    analysis = eliza.last_response
  else
    analysis = eliza.process_input(inbound)
  end

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message analysis
  end
  twiml.text
end
