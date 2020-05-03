require 'dotenv'
Dotenv.load

require 'httparty'
require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/application'
require './config/environments'

require './models/dog'
require './models/fact'
require './models/hook'

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
  redirect ENV['HOME_URL']
end

get '/api/facts' do
  content_type 'application/json', 'charset' => 'utf-8'

  facts = []
  success_response = false

  begin
    random_facts = Fact.get_random(params[:number])
    facts = random_facts.map{|f| f.body }
    success_response = true
  rescue Exception => e
    success_response = false
  end

  { facts: facts, success: success_response }.to_json
end

post '/api/facts/slack' do
  random_fact = Fact.get_random().first().message

  content_type 'application/json', 'charset' => 'utf-8'
  { response_type: "in_channel", text: random_fact }.to_json
end

get '/api/facts/slack' do
  redirect ENV['ERROR_URL'] if params['error'] == 'access_denied' || params[:code].nil?

  authorization = Dog.sniff(params[:code])

  redirect ENV['ERROR_URL'] unless authorization.success?

  webhook_url = authorization["incoming_webhook"]["url"]
  hook = Hook.new({ url: webhook_url })

  if hook.save
    welcome_msg = Dog.welcome_message
    send_webhook = Dog.bark_to(hook.url, welcome_msg)

    if send_webhook.success?
      redirect ENV['SUCCESS_URL']
    else
      redirect ENV['ERROR_URL']
    end
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
