require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?
require 'json'
require './telegram'

get '/telegram' do
  Telegram.build(line_length: params[:w], text: params[:text]).join("<br>")
end

post '/telegram.json' do
  content_type :json
  telegram = Telegram.build(line_length: params[:w], text: params[:text])

  {
    telegram_lines: telegram,
    line_count: telegram.length
  }.to_json
end