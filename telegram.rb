class Telegram
  def self.build(line_length:, text:)
    line_length ||= 50
    text ||= "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

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

    telegram
  end
  private_class_method :truncate_lines
end