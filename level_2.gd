extends Node2D

#variables
@onready var location = Vector2()
@onready var audio = $AudioStreamPlayer2D
@onready var inventory = preload("res://levels/inventory/inventory.tscn").instantiate()
@onready var speech = preload("res://speech/speech.tscn").instantiate()

#platforms
@onready var packed_platforms = [
	preload("res://platforms/BREAK/break_platform.tscn"),
	preload("res://platforms/TIMED/timed_platform.tscn")
]

#event listeners
func _on_entered_1b_body_entered(body):
	if body.name == "player":
		queue_free()
		Switcher.switch_scene("res://levels/L1MAIN/level_1b.tscn")

func _on_b_enter_body_entered(body):
	if body.name == "player":
		queue_free()
		Switcher.switch_scene("res://levels/L2MAIN/level_2b.tscn")

#self made functions
func platforms(): #initialise a layout that doesnt change too often 
	for i in range(10): #creates a pack of 10 platforms in a level
		var type = randi() % packed_platforms.size() #acts as the index for which scene to load 
		location.x = randi_range(350,1630) #intiates a random pos for each platform
		location.y = randi_range(430,880)
		var platform = packed_platforms[type].instantiate() #instantiates the randomised platform
		platform.position = location #sets the instance's location to the random pos
		add_child(platform) #adds final product to main level layout

# Called when the node enters the scene tree for the first time.
func _ready():
	platforms()
	add_child(inventory)
	add_child(speech)
	Global.player_pos = "Level 0"

func _process(_delta):
	if Global.music_off == true:
		audio.playing = false
