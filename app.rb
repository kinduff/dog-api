require 'dotenv'
Dotenv.load

require 'httparty'
require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/application'
require './config/environments'

require './models/fact'

#  ____                   _    ____ ___
# |  _ \  ___   __ _     / \  |  _ \_ _|
# | | | |/ _ \ / _` |   / _ \ | |_) | |
# | |_| | (_) | (_| |  / ___ \|  __/| |
# |____/ \___/ \__, | /_/   \_\_|  |___|
#              |___/

#
# Routes/Controllers
#
get '/' do
  redirect to('http://kinduff.com/dog-api')
end

get '/api/facts' do
  content_type 'application/json', 'charset' => 'utf-8'

  facts = []
  success_response = false

  begin
    random_facts = Fact.get_random(params[:number])
    facts = random_facts.map{|f| f.body }
    success_response = true
  rescue
    success_response = false
  end

  { facts: facts, success: success_response }.to_json
end

post '/api/facts/slack' do
  content_type 'application/json', 'charset' => 'utf-8'
  random_fact = Fact.get_random().first()
  message = "*Dog Fact ##{random_fact.id}*: #{random_fact.body}\n:dog: :dog: :dog:"
  { response_type: "in_channel", text: message }.to_json
end

get '/api/facts/slack' do
  redirect ENV['ERROR_URL'] if params['error'] == 'access_denied'

  # User authorization
  options = {
    body: {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      code: params[:code],
      redirect_uri: ENV['REDIRECT_URI']
    }
  }
  resp = HTTParty.post('https://slack.com/api/oauth.access', options)
  unless resp.success?
    redirect ENV['ERROR_URL']
  end

  # Webhook response
  webhook_url = resp["incoming_webhook"]["url"]
  options = {
    headers: {
      'Content-Type': 'application/json'
    },
    body: {
      text: "Welcome to Dog Facts!\n" +
      "You will now receive fun semi-irregular facts about DOGS! :dog: :tada:\n" +
      "You can also get a random fact by sending `/dogfact` from any channel."
    }.to_json
  }
  resp = HTTParty.post(webhook_url, options)
  if resp.success?
    redirect ENV['SUCCESS_URL']
  else
    redirect ENV['ERROR_URL']
  end
end

#
# Error handling
#
not_found do
  content_type 'text/plain'
  [404, '¯\_(ツ)_/¯']
end

error do
  content_type 'text/plain'
  [500, '(╯°□°）╯︵ ┻━┻']
end
