Program: COMP 3007 Assignment 2

Author:  Roy Xu 100999873

Version: 1.0.0

Perpose: For user to conver bmp files into ASCII art and 
	 find a bmp file in another, if it contains

Source Flies: 
	 comp3007_w19_100999873_a2_1.hs
	 comp3007_w19_100999873_a2_2.hs

Additional Files:
	 sample_image_to_find.bmp
	 sample_image_to_search.bmp
	 README.txt

Compilation: 
	 in Ghci use :l command to load and compile

Launch & Test:
	 Command to test part 1:
	  showAsASCIIArt (convertToASCIIArt ".:-=+*#%@" True (loadBitmap "comp3007_w19_100999873_a2_1.hs"))
	   or	 
	  showAsASCIIArt (convertToASCIIArt ".:-=+*#%@" False (loadBitmap "comp3007_w19_100999873_a2_1.hs"))

	 Command to test part 2:
	  searchASCII (convertToASCIIArt ".:-=+*#%@" True (loadBitmap "sample_image_to_search.bmp")) (convertToASCIIArt ".:-=+*#%@" True (loadBitmap "sample_image_to_find.bmp"))
