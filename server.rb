require 'sinatra'
require 'twilio-ruby'
require 'eliza'

elizabots = {}

post '/sms-quickstart' do
  message = params['Body']
  number = params['From']
  eliza = elizabots[number]

  if !eliza
    eliza = Eliza::Interpreter.new()
    elizabots[number] = eliza
    analysis = eliza.last_response
  else
    analysis = eliza.process_input(message)
    elizabots[number] = nil if eliza.done
  end

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message analysis
  end
  twiml.text
end
