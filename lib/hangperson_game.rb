class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    raise ArgumentError if !letter || letter == '' || (letter =~ /^[a-z]/i) == nil
    
    my_letter = letter.downcase
    valid = @word.downcase.include? my_letter
    
    if valid
      if !@guesses.include? my_letter
        @guesses += my_letter
      else
        valid = false
      end
    else
      if !@wrong_guesses.include? my_letter
        @wrong_guesses += my_letter
        valid = true
      end
    end
    
    valid
  end
  
  def word_with_guesses
    g = (@guesses == '' ? '1' : @guesses)
    @word.gsub(/[^#{g}]/i, '-')
  end
  
  def check_win_or_lose
    if @word.length > 0 && @word == word_with_guesses
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
