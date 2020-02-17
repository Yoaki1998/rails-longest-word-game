require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @randletter = []
    10.times { @randletter.push(('A'..'Z').to_a.sample) }
  end

  def score
    @randletter = params[:randletter].split(" ")
    @word = params[:word].upcase || "Nothing"
    a = @word.split("")
    b = a - @randletter
    if b == []
      if truc(params[:word])
        @word = "Congratulation #{@word} is good and English"
      else
        @word = "Congratulation #{@word} is good but no English"
      end
    else
      @word = "Sorry #{@word} can't be build with #{@randletter.join(' ')}"
    end
  end

  def truc(word)
    url = open("https://wagon-dictionary.herokuapp.com/#{word}")
    s = JSON.parse(url.read)
    s["found"]
  end
end
