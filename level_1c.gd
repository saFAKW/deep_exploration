extends Node2D

#variables
@onready var location = Vector2() #marks where the platform will land
@onready var pos = Vector2() #marks where the skeleton should instnatiate
@onready var audio = $AudioStreamPlayer2D
@onready var inventory = preload("res://levels/inventory/inventory.tscn").instantiate()

#holds the platform types to be used in this level so they are called/load at the same time
@onready var packed_scenes = [
	preload("res://platforms/BASIC/basic_platform.tscn"),
	preload("res://platforms/BREAK/break_platform.tscn")
]

#checks if player wishes to return to the main level one screen
func _on_m_area_body_entered(body):
	if body.name == "player":
		queue_free()
		Switcher.switch_scene("res://levels/L1MAIN/level_1.tscn")

#self made functions
func platforms(): #creates a random landscape to play against
	for i in range(10):
		var x = randi() % packed_scenes.size() #acts as the index for which scene to load 
		location.x = randi_range(350,1630) #intiates a random pos for each platform
		location.y = randi_range(430,880)
		var platform = packed_scenes[x].instantiate() #instantiates the randomised platform
		platform.position = location #sets the instance's location to the random pos
		add_child(platform) #adds final product to main level layout

func skeletons():
	for i in range(3):
		pos.x = randi_range(350,1630)
		pos.y = randi_range(430,880)
		var skeleton = preload("res://characters/SKELETON/skeleton_moves.tscn").instantiate()
		skeleton.position = pos
		add_child(skeleton)

#main functions
func _ready(): #using _ready to initialise a layout that doesnt change too often
	Global.player_pos = "LEVEL 1"
	skeletons()
	platforms()
	add_child(inventory)

func _process(_delta):
	if Global.music_off == true:
		audio.playing = false 
