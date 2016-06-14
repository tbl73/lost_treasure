class GameController < ApplicationController

	include GameHelper
  
  def home

  	#allows display of book pages from hash in game_helper
		@book = book_pages
		#allows display of story parts from hash in game_helper
		@start = story["start"]
		@start2 = story["start2"]

		#when parameters are passed, use them to decide which page to go to next
		choice = params[:input]
		if choice
			if choice == "yes"
				redirect_to step2_path
			elsif choice == "no"
				redirect_to ending_path(input: choice)
			else
		 		@invalid = "That wasn't a valid choice, please try again."
			end
		else
		#If no params are passed, it's the first visit to the page.  Reset the supplies for new player.  Check to see if there are any supplies in the database.  If so, destroy them.
	  	if Supply.all != []
	  		Supply.destroy_all
	  	end

	  	#create new supplies in the database
			Supply.create(name: "water")
			Supply.create(name: "flashlight")
			Supply.create(name: "nuts")
		end
  end

	def step2
		@directions = directions
		@start_yes = story["start_yes"]
		@jungle = story["jungle"]
		@fruit_list = %w(banana bananas mango mangoes papaya papayas guava guavas dragonfruit dragonfruits starfruit starfruits)
		choice = params[:input]
		if choice
			if (choice == "supplies") || (choice == "book") || (choice == "list")
				redirect_to display_path(input: choice)
			elsif (@fruit_list.include? choice)
				if Supply.where(name: choice) == []
					new_item = Supply.create(name: choice)
				end
				@collected = "You collected #{choice}. Choose another fruit or type exit."
			elsif choice == "exit"
				redirect_to river_path
			elsif choice == "back"
				redirect_to :back
			else
				@invalid = "That doesn't grow in this jungle; try again."
			end
		end
	end

  def display
  	@supplies = Supply.all
  	@book = book_pages
  	@choice = params[:input]
 	end

	def give(item)
		Supply.find_by(name: item).destroy
	end

	def river
		@directions = directions
		@river = story["river"]
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
		@directions = directions
		choice = params[:input]
		@supplies = Supply.all
		@boat = story["boat"]
		alternate = rand(1..3)
		if (alternate == 1) || (alternate == 2)
			redirect_to ending_path(input: alternate)
		else
			@boat_next = story["boat3"]
			@temple = story["temple1"]
			if choice
				monkeys(choice)
			end
		end
	end

	def bridge
		@directions = directions
		@bridge = story["bridge"]
		@temple = story["temple1"]
		@supplies = Supply.all
		choice = params[:input]

		if (choice == "supplies") || (choice == "book") || (choice == "list")
				redirect_to display_path(input: choice)
		else
			if choice
				monkeys(choice)
			end
		end
	end

	def monkeys(choice)
		@fruit_list = %w(banana bananas mango mangoes papaya papayas guava guavas dragonfruit dragonfruits starfruit starfruits)

		input_array = choice.split(" ")

		#set two variables to false as a means to break the 
		@action = false
		@gift = false

		@supplies = Supply.all
		#split the input into an array to look at each word
		input_array = choice.split(" ")

		#if the words include give and a fruit name, set variables to true
		input_array.each do |item|
			if item == "give"
				@action = true
			elsif Supply.where(name: item) != []
				give(item)
				if (@fruit_list.include? item)
					@gift = true
				end
			end
		end
		#if variables are true, move to next section; otherwise try again.
		if (@action == true) && (@gift == true)
			redirect_to temple_path
		else
			@invalid = "The monkeys keep throwing things at you.  What else can you do?"
		end
	end

	def temple
		@directions = directions
		@temple = story["temple2"]
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
		@directions = directions
		choice = params[:input]
		case choice
		when "left", "center", "shield"
			redirect_to ending_path(input: choice)
		when "right"
			@right = story["temple_hall_right"]
		when "supplies", "book", "list"
			redirect_to display_path(input: choice)
		when "mask"
			redirect_to door_path
		else
			@invalid = "That isn't one of the options, please try again."
		end
	end

	def ending
		choice = params[:input]
		#display different endings depending on the parameter passed
		case choice
		when "no"
			@ending = story["start_no"]
		when "shield"
			@ending = story["shield"]
		when "treasure" 
			@ending = story["treasure_room"]
		when "left"
			@ending =  story["temple_hall_left"]
		when "center"
			@ending = story["temple_hall_center"]
		when "1"	
			@boat = story["boat"]
			@ending = story["boat1"]
		when "2"
			@boat = story["boat"]
			@ending = story["boat2"]
		end
		
	end

	def door
		@directions = directions
		@door = story["hall2_mask"]
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

end