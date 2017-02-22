require 'sinatra'
# require 'sinatra/reloader'
require 'sass'

class Game
	attr_accessor :colors, :guess, :pattern, :suggestion_arr
	def initialize
		@colors = ["blue", "green", "brown", "purple", "red", "yellow"]
		@guess = []
		create_pattern
	end

	def create_pattern
		@pattern = []	
	
		4.times do
			number = rand(0..5)
			@pattern.push(@colors[number])
		end
		
		@pattern
	end

	def suggestion
		@suggestion_arr = []
		option1 = "black"
		option2 = "white"
		option3 = "none"
		
		4.times do |num|
			4.times do |num2|
				if @pattern[num] == @guess[num2]
					if num == num2
						@suggestion_arr.push(option1) 
					else
						@suggestion_arr.push(option2) 
					end
				end	
			end			
		end

		while @suggestion_arr.size <=3
			@suggestion_arr.push(option3)
		end

		@suggestion_arr.shuffle!
		@suggestion_arr
	end
end	

arr = Array.new
tips = Array.new
game = Game.new
counter = 0
get '/styles.css' do 
	scss :styles 
end

get '/' do
	erb :index
end

post '/result' do
	if params[:submit] == "OK" && counter <= 11
		game.guess = []
		game.guess.push(params[:first_color])
		game.guess.push(params[:second_color])
		game.guess.push(params[:third_color])
		game.guess.push(params[:fourth_color])

		arr.push(game.guess)
			
		game.suggestion

		tips.push(game.suggestion_arr)

		if game.guess != game.pattern 
			counter += 1
			erb :result, :locals => { :arr => arr, :counter => counter, :suggestion => tips }
		else
			arr = []
			tips = []
			counter = 0
			game = Game.new
			erb :index
		end
	else
		arr = []
		tips = []
		counter = 0
		game = Game.new
		erb :index
	end	
end