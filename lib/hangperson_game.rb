class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word,:guesses,:wrong_guesses


  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end


  def guess(str1)
    if str1 == "" || str1 =~/[^a-zA-Z]/ || str1 == nil
      raise ArgumentError.new("Empty string not accepted")
    end
    str1 = str1.downcase
    if word.include? str1
      if @guesses.include? str1
        return false
      else
        @guesses << str1
        return true
      end
    else
      if @wrong_guesses.include? str1
        return false
      else
        @wrong_guesses << str1
        return true
      end
    end
  end

  def word_with_guesses
    if @guesses.empty? and @wrong_guesses.empty?
      word = '-'
      1.upto(@word.length) {word<<'-'}
      return word
    end
    return @word.gsub(/[^#{@wrong_guesses}]/,'-') if @guesses.empty?
    @word.gsub(/[^#{@guesses}]/,'-')
  end

  def check_win_or_lose
    if wrong_guesses.size() >= 7
      return :lose
    elsif word_with_guesses == @word
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
