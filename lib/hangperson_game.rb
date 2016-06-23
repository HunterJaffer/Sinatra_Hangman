class HangpersonGame

  attr_accessor :word,:guesses,:wrong_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(guess)
    raise ArgumentError if guess == '' or guess =~ /[^a-zA-Z]/ or guess.nil?
    if !(@guesses=~/#{guess}/i) and !(@wrong_guesses=~/#{guess}/i)
      @guesses << guess.downcase if @word=~/#{guess}/i
      @wrong_guesses << guess.downcase if !(@word=~/#{guess}/i)
      return true
    end
    return false
  end

  def word_with_guesses
    if @guesses.empty? and @wrong_guesses.empty?
      word = ''
      1.upto(@word.length) {word<<'-' }
      return word
    end
    return @word.gsub(/[^#{@wrong_guesses}]/, '-') if @guesses.empty?
    @word.gsub(/[^#{@guesses}]/,"-")
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if @word==word_with_guesses
    return :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
