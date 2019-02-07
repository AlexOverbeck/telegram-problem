require 'sinatra'
require 'json'
require 'morse'
require './telegram'

post '/telegram.json' do
  content_type :json

  data = JSON.parse(request.body.read)
  telegram = Telegram.build(line_length: data['w'], text: data['text'])

  {
    telegram_text: telegram.join("\n"),
    telegram_html: telegram.join("<br>"),
    telegram_array: telegram,
    character_count: data['text'].length,
    line_count: telegram.nil? ? 0 : telegram.length
  }.to_json
end

post '/morse.json' do
  content_type :json
  data = JSON.parse(request.body.read)

  {
    original_text: data['text'],
    morse_code: Morse.encode(data['text'])
  }.to_json
end