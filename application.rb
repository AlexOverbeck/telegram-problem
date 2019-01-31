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

  puts "---------------------------------------------------------"
  puts "Params:\nw: #{params[:w]}\ntext: #{params[:text]}"
  puts "\n\nTelegram: \n\n #{telegram.join("\n")}"
  puts "\n\n====================================================="

  telegram.join('<br>')
end

post '/telegram.json' do
  content_type :json
  telegram = Telegram.build(line_length: params[:w], text: params[:text])

  puts "---------------------------------------------------------"
  puts "Params:\nw: #{params[:w]}\ntext: #{params[:text]}"
  puts "\n\n Telegram: \n\n #{telegram.join("\n")}"
  puts "\n\n====================================================="

  {
    telegram_lines: telegram,
    line_count: telegram.length
  }.to_json
end