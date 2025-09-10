extends Node2D

#variables
@onready var location = Vector2()
@onready var pos = Vector2()
@onready var audio = $AudioStreamPlayer2D
@onready var inventory = preload("res://levels/inventory/inventory.tscn").instantiate()
@onready var speech = preload("res://speech/speech.tscn").instantiate()


#platforms
@onready var packed_platforms = [
	preload("res://platforms/BREAK/break_platform.tscn"),
	preload("res://platforms/TIMED/timed_platform.tscn")
]

#event listeners
func _on_m_2__enter_body_entered(body):
	if body.name == "player":
		queue_free()
		Switcher.switch_scene("res://levels/L2MAIN/level_2.tscn")

func _on_m_3_enter_body_entered(body):
	if body.name == "player":
		queue_free()
		Switcher.switch_scene("res://levels/L3MAIN/level_3.tscn")

#self made functions 
func platforms(): #initialise a layout that doesnt change too often 
	for i in range(10): #creates a pack of 10 platforms in a level
		var type = randi() % packed_platforms.size() #acts as the index for which scene to load 
		location.x = randi_range(350,1630) #intiates a random pos for each platform
		location.y = randi_range(430,880)
		var platform = packed_platforms[type].instantiate() #instantiates the randomised platform
		platform.position = location #sets the instance's location to the random pos
		add_child(platform) #adds final product to main level layout

func skeletons():
	for i in range(5):
		pos.x = randi_range(350,1630)
		pos.y = randi_range(430,880)
		var skeleton = preload("res://characters/SKELETON/skeleton_moves.tscn").instantiate()
		skeleton.position = pos
		add_child(skeleton)

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player_pos = "Level 0"
	skeletons()
	platforms()
	add_child(inventory)
	add_child(speech)

func _process(_delta):
	if Global.music_off == true:
		audio.playing = false
