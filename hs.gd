extends Node2D

#variables 
#collating all the name label node pathways together for edits/updates 
@onready var ranking_names = [
	$first/first_name,
	$second/second_name,
	$third/third_name,
	$fourth/fourth_name,
	$fifth/fifth_name
	]
#collating all the score label node pathways together for edits/updates 
@onready var rankings_scores = [
	$first/first_score,
	$second/second_score,
	$third/third_score,
	$fourth/fourth_score,
	$fifth/fifth_score
	]
#the permanent storage for highscore values 
@onready var hs_records = "res://HS/highscores.txt"
@onready var audio = $AudioStreamPlayer

#event listeners
func _on_return_pressed():
	audio.play()
	get_tree().change_scene_to_file("res://MENU/menu.tscn")

#self made functions 
func file_reader(): #a test to check how the file prints in console
	var file = FileAccess.open(hs_records, FileAccess.READ) #opens file in read mode 
	var i = 0
	while not file.eof_reached() and i<5: #loops through the entire file and keeps in visual array range 
		var line = file.get_line() #retrieves the file, line by line 
		#string slices the entire line to extract the relevant data per position 
		ranking_names[i].text = line.substr(0,4) #returns player name 
		rankings_scores[i].text = line.substr(5) #returns score value 
		i+=1 #increments the index value 
		print(line.substr(0,4)) #prints the contents line by line to console
	file.close() 

func file_writer(player, num): #parameter where the player's final score is checked and issued to the leaderboard
	var file = FileAccess.open(hs_records, FileAccess.READ_WRITE)
	var i = 0 #index variable dedicated to the function 
	while not file.eof_reached(): #loops through the entire file and prints all lines 
		var line = file.get_line() 
		var content = line.substr(5)
		var character = line.substr(0,4)
		while num > int(content): #cecks for when the highscore is 
			i+=1
		character = character.replace("YOB", player.upper()) #replaces initial text file value
		content = content.replace("0", num) #replaces initial text file value
		file.store_string(character)
		file.store_string(content) #stores it permanently to file 
		ranking_names[i].text = line.substr(0,4)
		rankings_scores[i].text = player #updates the ranking label with new content 
	file.close() 
	
#main functions 
func _ready():
	file_reader()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.finished == true:
		file_writer(Global.official_name, Global.player_score)

