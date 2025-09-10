extends Node2D

#variables
@onready var location = Vector2() #marks where the platform will land
@onready var player = $player
@onready var audio = $AudioStreamPlayer2D

@onready var inventory = preload("res://levels/inventory/inventory.tscn").instantiate()

#holds the platform types to be used in this level so they are called/load at the same time
@onready var packed_platforms = [
	preload("res://platforms/BASIC/basic_platform.tscn"),
	preload("res://platforms/BREAK/break_platform.tscn"),
]

#event listeners
func _on_b_area_body_entered(body):
	if body.name == "player":
		queue_free()
		Switcher.switch_scene("res://levels/L1MAIN/level_1b.tscn")

func _on_c_area_body_entered(body):
	if body.name == "player":
		queue_free()
		Switcher.switch_scene("res://levels/L1MAIN/level_1c.tscn")

#self made functions
func platforms(): #initialise a layout that doesnt change too often 
	for i in range(10): #creates a pack of 10 platforms in a level
		var type = randi() % packed_platforms.size() #acts as the index for which scene to load 
		location.x = randi_range(350,1630) #intiates a random pos for each platform
		location.y = randi_range(430,880)
		var platform = packed_platforms[type].instantiate() #instantiates the randomised platform
		platform.position = location #sets the instance's location to the random pos
		add_child(platform) #adds final product to main level layout

#to reduce the number of lines of code
func collect_maker(type):
	type.get_parent()
	type.position = $flashlight.position
	add_child(type)

#main functions 
func _ready():
	Global.player_pos = "Level 1" #changes level labelling 
	platforms() #instantiates platforms so that the scene is loaded a new layout
	add_child(inventory) #brings inventory scene into main level
	if Global.player_powerup != "flashlight": #checks if a flashlight is in possesion
		var fl = preload("res://levels/inventory/flashlight.tscn").instantiate() #loads the flashlight
		collect_maker(fl)

func _process(_delta): #looping function per frames 'delta'
	if Global.music_off == true:
		audio.playing = false 
