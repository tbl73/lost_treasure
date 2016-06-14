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

		#if no params are passed, it's the first visit to the page.  reset the supplies for new player.  
		else
			#check to see if there are any supplies in the database.  if so, destroy them.
	  	if Supply.all != []
	  		Supply.destroy_all
	  	end

	  	#otherwise create new supplies in the database.
			Supply.create(name: "water")
			Supply.create(name: "flashlight")
			Supply.create(name: "nuts")
		end
  end

	def step2
		#variables for directions and story text
		@directions = directions
		@start_yes = story["start_yes"]
		@jungle = story["jungle"]
		#an array of fruits that can be gathered
		@fruit_list = %w(banana bananas mango mangoes papaya papayas guava guavas dragonfruit dragonfruits starfruit starfruits)
		
		#set variable of params passed in from user entry
		choice = params[:input]

		#if there are params, perform actions
		if choice
			#for supplies/book/actions
			if (choice == "supplies") || (choice == "book") || (choice == "list")
				redirect_to display_path(input: choice)
			#otherwise check to see if the entry is a fruit from the list
			elsif (@fruit_list.include? choice)
				#and see if it's already been added to supplies. if not, add it.
				if Supply.where(name: choice) == []
					new_item = Supply.create(name: choice)
				end
				@collected = "You collected #{choice}. Choose another fruit or type exit."
			#if param is exit, move on to the next part of the story.	
			elsif choice == "exit"
				redirect_to river_path
			#otherwise display a message asking for one of the correct options
			else
				@invalid = "That doesn't grow in this jungle; try again."
			end
		end
	end

  def display
  	#create variables to display supplies/book/actions
  	@supplies = Supply.all
  	@book = book_pages
  	@choice = params[:input]
 	end

	def give(item)
		#if user gives away a supply, find in model and delete
		Supply.find_by(name: item).destroy
	end

	def river
		#variables for directions and story
		@directions = directions
		@river = story["river"]

		#set variable of params from user entry
		choice = params[:input]
		#if there are params, perform action
		if choice
		
			#case statement to determine which part of the storyto display for each user entry.
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
		#variable for directions, story
		@directions = directions
		@boat = story["boat"]

		#need supply list for monkey function
		@supplies = Supply.all

		#params from user entry
		choice = params[:input]

		#the boat story has three random alternatives. first set a variable to a random number between one and three, then specify the path based on the number
		alternate = rand(1..3)
		if (alternate == 1) || (alternate == 2)
			redirect_to ending_path(input: alternate)
		else
			@boat_next = story["boat3"]
			@temple = story["temple1"]
			#if a user has entered params, call the monkeys method and pass that param
			if choice
				monkeys(choice)
			end
		end
	end

	def bridge
		#variables for directions/story/supply list - need supplies for monkey function
		@directions = directions
		@bridge = story["bridge"]
		@temple = story["temple1"]
		@supplies = Supply.all

		#params from user entry
		choice = params[:input]

		#if there are user params, either display supplies/book/list or call the monkeys method and pass the params
		if choice
			if (choice == "supplies") || (choice == "book") || (choice == "list")
				redirect_to display_path(input: choice)
			else
				monkeys(choice)
			end
		end
	end

	def monkeys(choice)
		#puzzzle to get past the monkeys
		#need list of fruits to compare against
		@fruit_list = %w(banana bananas mango mangoes papaya papayas guava guavas dragonfruit dragonfruits starfruit starfruits)

		#if input is multiple words, split into an array for comparison purposes
		input_array = choice.split(" ")

		#variables are used to test conditions - set as false, then if they become true, move on 
		@action = false
		@gift = false

		#need to have supplies in a list
		@supplies = Supply.all
		#split the input into an array to look at each word
		input_array = choice.split(" ")

		#check to see if the action (give) is in the user input.  also check to see if they have listed a fruit that they picked up earlier.  if both these conditions are set to true, move on.  otherwise try again.
		input_array.each do |item|
			#if they use the give action
			if item == "give"
				@action = true

			#if the user input includes the give action and an item in their supply list, call the give action on that item.  if the item is also a fruit from the fruit list, puzzle is solved and user can move forward
			elsif Supply.where(name: item) != [] && (@action == true)
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
		#variables for story/directions/user input
		@directions = directions
		@temple = story["temple2"]
		choice = params[:input]

		#if there is user input, perform actions
		if choice
			#for correct user input redirect to display or next part of story
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
		#variables for directions and user input
		@directions = directions
		choice = params[:input]

		case choice
		#go to display of supplies/book/list
		when "supplies", "book", "list"
			redirect_to display_path(input: choice)
		#these three user inputs are all possible endings, pass them to the ending path as params	
		when "left", "center", "shield"
			redirect_to ending_path(input: choice)
		#this option displays one part of the story
		when "right"
			@right = story["temple_hall_right"]
		#this option sends to a puzzle	
		when "mask"
			redirect_to door_path
		else
			@invalid = "That isn't one of the options, please try again."
		end
	end

	def ending
		choice = params[:input]
		#display different endings depending on the parameter passed. each ending is called from the hash in the game helper
		case choice
		when "no"
			@ending = story["start_no"]
		when "shield"
			@ending = story["shield"]
		when "treasure" 
			@ending = story["treasure_room"]
			@win = "YOU WIN!"
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
		#puzzle to get past door
		#variables for directions, story, user params
		@directions = directions
		@door = story["hall2_mask"]
		choice = params[:input]

		#array of correct solution
		right_colors = ["red", "red", "red", "yellow", "blue", "black"]

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