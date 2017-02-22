require 'sinatra'
require 'sinatra/reloader'
require 'sass'

class Game
	def initialize
		@colors = ["blue", "green", "brown", "purple", "red", "yellow"]
		@positions = [1,2,3,4,5,6]
		@guess = []
	end

	def create_pattern
		@human_or_computer = 2
		
		@code = []

			4.times do |num|
				@color = rand(0..5)
				@code[num] = @colors[@color]
			end
		
		puts
	end

	def prompt(attempt)
		
		puts "Please, enter your sequence for the attempt number #{attempt}"
		puts "(1 for blue, 2 for green, 3 for brown, 4 for purple, 5 for red, 6 for yellow)"
		4.times do |num|
			print "Color of the peg number #{num+1}: "
			answer = gets.chomp
			answer = answer.to_i
			@guess[num] = @colors[answer-1]
		end
		
	end	


	def won
		@guess == @code 

	end


	def suggestion
		@option1 = "black"
		@option2 = "white"
		@option3 = "none"
		@suggest_arr = []
		
		4.times do |num|
			4.times do |num2|
				if @code[num] == @guess[num2]
					if num == num2
						@suggest_arr.push(@option1) 
					else
						@suggest_arr.push(@option2) 
					end
				end	
			end			
		end

		while @suggest_arr.size <=3
			@suggest_arr.push(@option3)
		end

		@suggest_arr.shuffle!

		puts
		puts "Here's a suggestion for you:"


		4.times do |num|
			if num == 2
				puts
				print "#{@suggest_arr[num]} "
			else
				print "#{@suggest_arr[num]} "
			end
		end
		puts
		puts	
	end

	def computer(attempt)
		temp_arr = []

		if attempt == 0
			4.times do |num|
				@guess[num] = @colors[rand(0..5)]
			end
		else
			4.times do |num|
				4.times do |num2|
					if @code[num] == @guess[num2]
						temp_arr.push(@guess[num2])
					end	
				end
			end

		@guess = temp_arr & @guess
		
		

		end

		while @guess.size < 4
			@guess.push(@colors[rand(0..5)])
		end

	end

	def play
		num = 0
		
		if @human_or_computer == 2
			while !won && num <=11
				prompt(num+1)
				suggestion
				num = num + 1

			end
		else
			while !won && num <=11
				puts "Attempt number #{num+1}"
				computer(num)
				suggestion
				num = num + 1

			end	
		end


	end


end	

=begin
game1 = Game.new
game1.create_pattern
game1.play
=end


get '/styles.css' do 
	scss :styles 
end

get '/' do
	erb :index
end