class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(str1)
    raise ArgumentError if str1 == nil
    if str1 == ''
      raise ArgumentError.new("No blank spaces")
    end
    str1 = str1[/[a-zA-Z]+/]
    raise ArgumentError.new("Only letters") if str1 == nil
    str1 = str1.downcase
    if(@word.include? str1)
      if !@guesses.include? str1    
        @guesses += str1
      else
        return false
      end
    else
      if !@wrong_guesses.include? str1
        @wrong_guesses += str1 
      else
        return false
      end
    end
  end
  
  def word_with_guesses()
    random_word = ""
    0.upto(@word.size - 1) do |x|
        random_word += "-"
    end
    @guesses.chars do |char|
      0.upto(@word.size - 1) do |x|
        if @word[x] == char
        	random_word[x] = char
        end
      end
    end
    return random_word
  end
  
  def check_win_or_lose()
    if word_with_guesses() != @word && guesses.size() + wrong_guesses.size() >= 7
      return :lose
    elsif word_with_guesses() == @word
      return :win
    else
      return :play
    end
    
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
