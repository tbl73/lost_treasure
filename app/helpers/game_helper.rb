module GameHelper


#this is a hash that contains the text of the story
	def story
	  @story_hash = {
			"start" => "You are in a junk store in South America, when you stumble upon the journal of Sir Reginald Higginbotham, the famous explorer, who disappeared many years ago, searching for the lost treasure of Z.  Sir Reginald was last seen in this very town, and what happened to him has long been a mystery. No one had found a trace of even his leather hat.  Leafing through the pages, you find that many of the pages are smeared and difficult to read.  You can make out a few words.",

			"start2" => "Most interesting of all is a sketch in the back of the book.",

			"start3" => "Could this be a map to the treasure?  Do you dare try and find it?  Will you avoid the fate of Sir Reginald???  To search for the treasure, type yes and press enter. If you choose not to go on the hunt, type no and press enter.",

			"start_no" => "You decide to ignore the clues in the journal.  While you live a long and eventful life, you always wonder what would have happened if you had found the treasure....",

			"start_yes" => "The first step in your treasure hunt is to find a guide.  You ask around in the town, and everyone mentions that Atilio knows the jungle better than anyone.  He agrees to help you in your quest.  When you show him the drawing, he knows of a place where three such rocks are close to a river.  He is willing to bring you to the spot, although he will not cross the river, because he says that land is cursed.  You and Atilio gather supplies - the few readable pages from the journal, water, a flashlight, nuts.  You plan to gather more food along the way, as there is plenty available in the jungle.",

			"jungle" => "You enter the jungle.  As you walk, you marvel at the plants and animals around you.  You see bananas, mangoes, papayas, guava, dragonfruit, and starfruit.  You decide to gather fruit for your journey.  What type of fruit do you want to pick up? Type the fruit name (as many as you want) - type exit when complete.",

			"river" => "As you walk, Atilio tries to convince you not to cross the river.  He tells you stories of those who had disappeared beyond its banks, never to return again.  He says those few warriors who returned all told crazy stories of red eyes and wide yellow mouths. When you finally reach the wide, deep river, you see two options for getting across.  There is a rickety rope bridge or a dilapidated boat.  Which crossing will you choose?  Type boat or bridge.",

			"boat" => "Atilio still refuses to cross the river, so you say farewell.  You pick up a branch to use as a pole and climb into the boat.  The boat leaks a tiny bit, but your pole works fairly well.  You are making good progress when suddenly you see an angry hippo coming towards you!  You attempt to fend him off with your pole, but 3,300 pounds of aggression is far too much to fight, and your boat is capsized....",
			
			"boat1" => "As your boat tips over, the edge of it hits you in the head.  You dazedly attempt to swim for shore, but the water is too deep and wide, and instead you drown.",

			"boat2" => "You aren't too far from shore when the boat tips over.  You manage to swim away while the hippo is still distracted by the boat.  You crawl out of the water, relieved to be on shore.  Luckily, your pack is still securely attached to you.  After recovering for a while on the riverbank, you begin to hike towards a mound in the distance.  As you approach, you realize it's a stone temple covered with vines.  It looks like you've found the location from the map!",

			"boat3" => "You are knocked unconscious as the boat is overturned.  Luckily, you get caught in your branch with your head above water.  You drift downstream, eventually washing ashore on a little beach.  You are found by some local people - you have no belongings and no memory of what you were doing in South America.  They nurse you back to health, and eventually you return home, always wondering how you'd ended up in the river.",

			"bridge" => "Atilio still refuses to cross the river, so you say farewell. You inch your way onto the rope bridge, constantly testing each step.  You are moving very slowly along, when you notice that the ropes seem to swaying more and more.  You take a quick glance behind you, and notice that the rope appears to be about to break.  You speed up, in a desperate race to make the other side.  You leap off the bridge and make it to the edge just as the last rope breaks.  You are very relieved to be on solid ground.  After a short rest, you begin to hike towards a mound in the distance.  As you approach, you realize it's a stone temple covered with vines.  It looks like you've found the location from the map!",

			"temple1" => "As you approach the temple, you see an opening in the vines.  Suddenly, you are startled to feel something hit you in the shoulder.  You look up and notice a troop of monkeys throwing grass and small stones at you.  You have to make your way past the monkeys to get into the temple - how can you distract them??",

			"temple2" => "The monkeys are excited to see your gift.  As they move away to investigate, you step inside and pull out your flashlight.  Your eyes adjust to the dim light, and you start down a corridor.  The walls are covered with a pattern of six repeating colors - three reds, yellow, blue and black.  After a few yards, you find an antechamber with three openings.  Which opening should you choose?  Type left, center or right.",

			"temple_hall_left" => "The passageway seems to have a dim light in the distance.  As you enter, you find it slants steeply downhill.  The path underfoot is uneven, and you trip.  You reach out to try and stop your forward motion, but instead tumble and slide down the slope until you fall right off an edge.  You land, badly injured, in a large pit. A small beam of sunlight shines from a chink in the stones up near the ceiling.  As you look around in a daze, your glance falls upon a skeleton with a leather hat.  As you start to pass out, you realize both that you've solved the mystery of Sir Reginald's fate, and that you will soon share it....",

			"temple_hall_center" => "As you move along the passage, you see signs that others have passed this way before you.  The passage is partially blocked, but you are able to wind your way through it.  You enter a chamber and are dismayed to discover that any treasure that might once have been contained inside is long gone.  There are a few broken bits that might once have been statues, but nothing else.  You do your best to explore the other passages, but they are totally blocked by fallen stones.  While you live a long and happy life, you always wonder what would have happened if you'd found the treasure....",

			"temple_hall_right" => "You shine your light into the passageway.  You see that it has many fallen rocks, but you think you can make your way through.  You scramble over and around the rocks, eventually dead-ending in another hallway.  You can make out two doors. One has some kind of mask above it, and the other has a pattern that looks like a shield.  Type shield or mask to go toward that door.",

			"hall2_shield" => "You come to a door and open it.  You peer into the dark haze and creep inside.  You notice that you feel slightly woozy.  Suddenly you catch sight of giant glowing red eyes and a gaping yellow maw looming toward you.  You step back in horror.  Is it moving towards you?  Terrified, you try to get out of the room, but you trip and fall.  The air by the floor is less misty, and your mind clears a bit.  You need to get out of this air!  You crawl slowly out of the room, and in the clear air of the hallway, you realize that the face was merely an enormous stone statue.  The mist must have somehow caused you to hallucinate.  No wonder the warrriors were so terrified!  You try to go down the hallway in the other direction, but the passage is completely blocked by fallen rocks.  You can't find any way through, and you finally make your way back across the river to town, always wondering what would have happened if you'd found the treasure.",

			"hall2_mask" => "As you approach the door, you see a complex series of colored stones in red, black, yellow, and blue.  You push on the door but can find no way to open it.  As you poke and prod, you discover that some of the stones can be moved.  Perhaps they form some kind of combination lock!  But what could the lock be?  You must think of how many stones to press and which colors....",

			"treasure_room" => "You hear a loud click.  When you push against the door, it opens. You enter the room, amazed at the glint of jewels and gold around the room.  You found the treasure!  You carefully place a small but beautiful stone idol with ruby eyes into your pack.  You leave the temple and make your way downstream until you can cross the river.  Back in town, you contact the local university to tell them of your find.  You are granted a huge finder's fee and widely celebrated for one of the greatest archaeological finds of the last fifty years.  After spending some time in the area, you set off again - how will you top this adventure??"

		}
	end

	#this hash contains the display of the book pages
	def book_pages
		@book = {
				"sketch" =>
				"	------------------------------------------
				|                                          |
				|                -----                     |
				|               /  _  \\                    |
				|              /  | |  \\                   |
				|              ---------                   |
				|                                          |
				|      ____             _____              |
				|     /    \\____       /|    \\__           |
				|    /          \\_____/ |       \\_______   |
				|      _____            |____              |
				|     /     \\____       /*   \\__           |
				|    /           \\_____/        \\_______   |
				|                                          |
				|                                          |
				|                        _                 |
				|                       / \\__  ___         |
				|                      /__/  \\/   \\        |
				|                        /____\\____\\       |
				|                                          |
				|                                          |
				 ------------------------------------------",

				 "page1" =>
			 	"	------------------------------------------
				|                                          |
				|                                          |
				|    -oday-- met a ------------- loca-     |
				|    trib----- confirme------uspicions.    |
				|    Now I kn---how---------tr--sur-----.  |
				|              > <                         |
				|                                          |
				|         R-----R--Y----B-                 |
				|                                          |
				 ------------------------------------------",

			}
	end
	
end
