require 'sinatra'
require 'logger'
require 'json'
require './telegram'

if development?
  require 'sinatra/reloader' 
  require 'pry'
end

set :logger, Logger.new(STDOUT)

# Basic telegram test
get '/telegram' do
  telegram = Telegram.build(line_length: params[:w], text: params[:text])

  logger.info [
    "\nTelegram: -------------------------------------------",
    "\n #{Array(telegram).join("\n")}",
    "\n====================================================="
  ].join("\n")

  Array(telegram).join('<br>')
end

post '/telegram.json' do
  content_type :json

  logger.info [
    "Params: -----------------------------------------------",
    params
  ].join("\n")

  telegram = Telegram.build(line_length: params[:w], text: params[:text])

   logger.info [
    "\nTelegram: -------------------------------------------",
    "\n #{Array(telegram).join("\n")}",
    "\n====================================================="
  ].join("\n")

  {
    telegram_lines: telegram,
    line_count: telegram.nil? ? 0 : telegram.length
  }.to_json
end