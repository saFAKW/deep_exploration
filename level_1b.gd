extends Node2D

#variables
@onready var audio = $AudioStreamPlayer2D
@onready var location = Vector2()
@onready var inventory = preload("res://levels/inventory/inventory.tscn").instantiate()
@onready var speech = preload("res://speech/speech.tscn").instantiate()

#holds the platform types to be used in this level so they are called/load at the same time
@onready var packed_scenes = [
	preload("res://platforms/BASIC/basic_platform.tscn"),
	preload("res://platforms/BREAK/break_platform.tscn")
]

#event listeners
func _on_m_1_area_body_entered(body):
	if body.name == "player":
		queue_free()
		Switcher.switch_scene("res://levels/L1MAIN/level_1.tscn")

func _on_m_2_area_body_entered(body):
	if body.name == "player":
		queue_free()
		Switcher.switch_scene("res://levels/L2MAIN/level_2.tscn")

#self-made functions
func platforms():
	for i in range(10):
		var x = randi() % packed_scenes.size() #acts as the index for which scene to load 
		location.x = randi_range(350,1630) #intiates a random pos for each platform
		location.y = randi_range(430,880)
		var platform = packed_scenes[x].instantiate() #instantiates the randomised platform
		platform.position = location #sets the instance's location to the random pos
		add_child(platform) #adds final product to main level layout

#main functions 
func _ready(): #runs once upon the scene is loaded for the first time
	Global.player_pos = "Level 1"
	platforms()
	add_child(speech) #introduces the speech option 
	add_child(inventory) #brings inventory scene into main level

func _process(_delta):
	if Global.music_off == true:
		audio.playing = false 
