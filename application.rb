require 'sinatra'
require 'json'
require './telegram'

if development?
  require 'sinatra/reloader' 
  require 'pry'
end

# Basic telegram test
get '/telegram' do
  telegram = Telegram.build(line_length: params[:w], text: params[:text])

  telegram.join('<br>')
end

post '/telegram.json' do
  content_type :json
  telegram = Telegram.build(line_length: params[:w], text: params[:text])

  {
    telegram_lines: telegram,
    line_count: telegram.length
  }.to_json
end