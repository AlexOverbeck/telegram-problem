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
  
  logger.info "\n/telegram used -- Telegram: \n\n #{telegram.join("\n")} \n\n==================================================="
  
  telegram.join('<br>')
end

post '/telegram.json' do
  content_type :json
  telegram = Telegram.build(line_length: params[:w], text: params[:text])

  logger.info "\n/telegram.json -- Telegram: \n\n #{telegram.join("\n")} \n\n==================================================="
  {
    telegram_lines: telegram,
    line_count: telegram.length
  }.to_json
end