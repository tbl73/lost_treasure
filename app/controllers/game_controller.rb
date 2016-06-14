class GameController < ApplicationController

	include GameHelper
  
  def home

		@book = book_pages

		if params[:input]
			if params[:input] == "yes"
				redirect_to step2_path
			elsif params[:input] == "no"
				redirect_to ending_path
				
			else
		 		@invalid = "That wasn't a valid choice, please try again."
			end
		end
  end

	def step2
		@supplies = supply_list
		@book = book_pages

		@fruit_list = %w(banana bananas mango mangoes papaya papayas guava guavas dragonfruit dragonfruits starfruit starfruits)
		choice = params[:input]
		if choice
			if (choice == "supplies") || (choice == "book") || (choice == "list")
				redirect_to display_path(paramschoice)
			elsif (@fruit_list.include? choice)
				@supplies.push(choice)
				@collected = "You collected #{choice}. Choose another fruit or type exit."
			elsif "exit"
				redirect_to river_path
			else
				@invalid = "That doesn't grow in this jungle; try again."
			end
		end
	end

  def display
  	@supplies = supply_list
  	@book = book_pages
  	choice = params[:input]
  	if choice == "back"
  		redirect_to :back
  	end
  end

	def supply_list
		@supply_list = %w(water flashlight nuts)
	end

	def book
		@book = book_pages
		#display name of book pages
		@book.each do |key, value|
			puts key.to_yaml
		end
		#get user choice of which book page to look at
		puts "Which page would you like to see?".to_yaml
		choice = gets.chomp.downcase
		#display user chosen page
		puts @book[choice]
		sleep(3)
	end

	def action_list
		puts "Type \"give\" to give an item to someone.".to_yaml
	end

	def give(item)
		@supplies = supply_list
		@supplies.delete(item)
	end
end