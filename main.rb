require 'sinatra'
require 'sinatra/reloader'
require 'sass'

class Game
	attr_accessor :colors, :guess, :pattern
	def initialize
		@colors = ["blue", "green", "brown", "purple", "red", "yellow"]
		@guess = []
		@suggestion = []
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
		@suggestion = []
		option1 = "black"
		option2 = "white"
		option3 = "none"
		
		4.times do |num|
			4.times do |num2|
				if @pattern[num] == @guess[num2]
					if num == num2
						@suggestion.push(option1) 
					else
						@suggestion.push(option2) 
					end
				end	
			end			
		end

		while @suggestion.size <=3
			@suggestion.push(option3)
		end

		@suggestion.shuffle!
		@suggestion
	end
end	

=begin
game1 = Game.new
game1.create_pattern
game1.play
=end

arr = Array.new
game = Game.new
counter = 0
get '/styles.css' do 
	scss :styles 
end

get '/' do
	erb :index
end

post '/result' do
	if params[:submit] == "OK"
		colors = Array.new
		colors[0] = params[:first_color]
		colors[1] = params[:second_color]
		colors[2] = params[:third_color]
		colors[3] = params[:fourth_color]
		arr.push(colors)
		counter += 1
		erb :result, :locals => { :arr => arr, :counter => counter}
	else
		arr = []
		erb :index
	end	
end