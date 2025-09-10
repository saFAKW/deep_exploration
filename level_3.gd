extends Node2D

#variables
#general
@onready var location = Vector2() #marks where the platform will land
@onready var marker = Vector2()
@onready var pos = Vector2()
@onready var audio = $AudioStreamPlayer2D
@onready var player = $player
@onready var inventory = preload("res://levels/inventory/inventory.tscn").instantiate()
@onready var speech = preload("res://speech/speech.tscn").instantiate()

#holds the platform types to be used in this level so they are called/load at the same time
@onready var packed_platforms = [
	preload("res://platforms/BREAK/break_platform.tscn"),
	preload("res://platforms/TIMED/timed_platform.tscn")
]

#boolean check vriables 
@onready var drop = false 

#event listeners
func _on_enter_2_body_entered(body):
	if body.name == "player": 
		queue_free()
		Switcher.switch_scene("res://levels/L2MAIN/level_2b.tscn")

func _on_enter_3b_body_entered(body):
	if body.name == "player":
		queue_free()
		Switcher.switch_scene("res://levels/L3MAIN/level_3b.tscn")

func _on_enter_4_body_entered(body):
	if body.name == "player":
		queue_free()
		Switcher.switch_scene("res://levels/L4MAIN/level_4.tscn")

#earthquake response
func _on_area_1_body_entered(body):
	if body.name == "player": #ensures only the player triggers the event
		drop = true 

#self made functions
func platforms(): #initialise a layout that doesnt change too often 
	for i in range(12): #creates a pack of 10 platforms in a level
		var type = randi() % packed_platforms.size() #acts as the index for which scene to load 
		location.x = randi_range(350,1630) #intiates a random pos for each platform
		location.y = randi_range(430,880)
		var platform = packed_platforms[type].instantiate() #instantiates the randomised platform
		platform.position = location #sets the instance's location to the random pos
		add_child(platform) #adds final product to main level layout

func debris():
	for i in range(50):
		marker.x = randi_range(30, 1790)
		marker.y = randi_range(370, 380)
		var rock = preload("res://levels/L3MAIN/debris.tscn").instantiate()
		rock.get_parent()
		rock.position = marker
		add_child(rock)
	drop = false 

func skeletons():
	for i in range(3):
		pos.x = randi_range(350,1630)
		pos.y = randi_range(430,880)
		var skeleton = preload("res://characters/SKELETON/skeleton_moves.tscn").instantiate()
		skeleton.position = pos
		add_child(skeleton)

#main functions
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player_pos = "LEVEL -1"
	platforms() 
	skeletons()
	add_child(inventory)
	add_child(speech)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.music_off == true:
		audio.playing = false 
	elif drop == true:
		debris()

