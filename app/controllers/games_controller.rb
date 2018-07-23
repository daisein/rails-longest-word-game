require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @random_array = (0...8).map { (65 + rand(26)).chr }.join
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params['word']}"
    hello = open(url).read
    check_word = JSON.parse(hello)

  if check_word["found"] == false
    @your_score = 0
    @your_message = "not an english word"
  elsif params[:word].upcase.chars.all? { |char| params[:random_array].include? char } == false
    @your_score = 0
    @your_message = "the given word is not in the grid" if check_word["found"] == true
  elsif check_word["word"].upcase.chars.any? {|e| check_word["word"].upcase.count(e) > params[:random_array].count(e)}
    @your_score = 0
    @your_message = "not in the grid"
  elsif check_word["found"] == true
    @your_score = 1000 + params[:word].size * 1000
    @your_message = "well done"
  end
  end

  def home
  end

end
