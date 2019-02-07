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
  english = Morse.decode(data['text'])
  morse_code = Morse.encode(data['text'])

  {
    english: english == "?" ? data['text'] : english,
    morse_code: morse_code.strip.length == 0 ? data['text'] : morse_code
  }.to_json
end