class Telegram
  def self.build(line_length:, text:)
    return if text.nil? || line_length.nil?
    
    puts "---------------------------------------------------------"
    puts "Params:\nline_length: #{line_length}\ntext: #{text}"
    
    truncate_lines(max_line_length: line_length, text: text)
  end

  def self.truncate_lines(max_line_length:, text:)
    telegram = []
    current_line = ""
    spaces = 0
    current_charater_length = 0

    text.split(' ').each do |word|
      space_word_takes_up = word.length + spaces

      if (current_charater_length + space_word_takes_up) <= max_line_length
        spaces += 1
        current_charater_length += word.length
        current_line = [current_line, word].join(' ')
      else
        spaces = 0
        telegram << current_line.strip
        current_line = word
        current_charater_length = word.length
      end
    end

    puts "\n\nTelegram: \n\n #{telegram.join("\n")}"
    puts "\n\n====================================================="
    
    telegram
  end
  private_class_method :truncate_lines
end