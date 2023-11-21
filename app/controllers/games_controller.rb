require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = (0...8).map { (65 + rand(26)).chr.upcase }
  end

  def score
    # take the params from the form
    whole_word = params[:word].upcase
    @word = params[:word].upcase.split("")
    letters = params[:letters]
    # declare variable for reply
    @reply = ''
    # declare variable for url
    url = "https://wagon-dictionary.herokuapp.com/#{whole_word}"

    # check if all of the letters in your word occur not more than once in the @letters array
    word_check_letters = @word.all? {|letter|@word.count(letter) <= letters.count(letter)}

    # check if the word exists through the API
    word_checker = JSON.parse(URI.open(url).read)
    word_check_english = word_checker['found']

    # create conditions based on then use cases
    if word_check_letters == false
      @reply = "Sorry but the test cannot be build out of #{letters}"
    elsif word_check_letters == true && word_check_english == false
      @reply = "Sorry but #{whole_word} is not a valid English word"
    else
      @reply = "Congratulations!</strong> #{whole_word} is a valid word."
    end
  end
end
