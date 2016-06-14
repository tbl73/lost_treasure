class GameController < ApplicationController

	include GameHelper
  
  def home

		@book = book_pages

		if params[:input]
			if params[:input] == "yes"
				redirect_to step2_path
			elsif params[:input] == "no"
				redirect_to ending_path(input: choice)
				
			else
		 		@invalid = "That wasn't a valid choice, please try again."
			end
		end
  end

	def step2
		water = Supply.create(name: "water")
		flashlight = Supply.create(name: "flashlight")
		nuts = Supply.create(name: "nuts")

		@fruit_list = %w(banana bananas mango mangoes papaya papayas guava guavas dragonfruit dragonfruits starfruit starfruits)
		choice = params[:input]
		if choice
			if (choice == "supplies") || (choice == "book") || (choice == "list")
				redirect_to display_path(input: choice)
			elsif (@fruit_list.include? choice)
				new_item = Supply.create(name: choice)
				@collected = "You collected #{choice}. Choose another fruit or type exit."
			elsif choice == "exit"
				redirect_to river_path
			else
				@invalid = "That doesn't grow in this jungle; try again."
			end
		end
	end

  def display
  	@supplies = Supply.all
  	@book = book_pages
  	@choice = params[:input]
  	if @choice == "back"
  		redirect_to :back
  	end
  end


	def give(item)
		@supplies = supply_list
		@supplies.delete(item)
	end

	def river
		choice = params[:input]
		if choice
			case choice
			when "supplies", "book", "list"
				redirect_to display_path(input: choice)
			when "boat"
				redirect_to boat_path
			when "bridge"
				redirect_to bridge_path
			when "exit"
				redirect_to river_path
			else
				@invalid = "That isn't one of the options, please try again."
			end
		end
	end

	def boat
		@alternate = rand(1..3)
	end

	def bridge

	end

	def temple
		choice = params[:input]
		if choice
			case choice
			when "supplies", "book", "list"
				redirect_to display_path(input: choice)
			when "right", "center", "left"
				redirect_to hall_path(input: choice)
			else
				@invalid = "That isn't one of the options, please try again."
			end
		end
	end

	def hall
		choice = params[:input]
		case choice
		when "left"
			@left =  story["temple_hall_left"]
		when "center"
			@center = story["temple_hall_center"]
		when "right"
			@right = story["temple_hall_right"]
		when "supplies", "book", "list"
			redirect_to display_path(input: choice)
		when "mask"
			redirect_to door_path
		when "shield"
			redirect_to ending_path(input: choice)
		else
			@invalid = "That isn't one of the options, please try again."
		end
	end

	def ending
		choice = params[:input]
		if choice == "no"
			@ending = story["start_no"]
		elsif choice == "shield"
			@ending = story["shield"]
		elsif 
			@ending = story["treasure_room"]
		end
	end

	def door
		right_colors = ["red", "red", "red", "yellow", "blue", "black"]
		choice = params[:input]

		#check to see if any parameters have been passed
		if choice
			#check to see if the user wants to look at the supplies/book/actions
			if (choice == "supplies") || (choice == "book") || (choice == "list")
				redirect_to display_path(input: choice)

			#otherwise split the params into an array
			else
				user_colors = choice.split(" ")
			
				#if the array matches the correct answer, go to next step			
				if user_colors == right_colors
					redirect_to ending_path(input: "treasure")
				#otherwise, try again
				else
					@incorrect = "Nothing happens.  Perhaps you have the wrong order.  You try again..."
				end
			end
		end
	end

	def monkeys

	end

end
=begin

def monkeys
	#set two variables to false and then test against them
	action = false
	gift = false
	fruit = ""

	#until both variables are set to true by comparison, keep looping
	until action == true && gift == true
		input = gets.chomp.downcase
		input_array = input.split(" ")
		
		if (input == "supplies") || (input == "list") || (input == "book")
			options(input)
		else
			input_array.each do |item|
				if item == "give"
					action = true
				elsif (@supplies.include? item) 
					give(item)
					if (@fruit_list.include? item)
					gift = true
					end
				end
			end
		end
		puts "The monkeys keep throwing things at you.  What can you do?".to_yaml
	end
	#go to the next step in the story
	temple2(@story_hash)
end
=end
