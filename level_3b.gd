extends Node2D

#constants

#variables
@onready var location = Vector2() #marks where the platform will land
@onready var player = $player
@onready var inventory = preload("res://levels/inventory/inventory.tscn").instantiate()
@onready var speech = preload("res://speech/speech.tscn").instantiate()

#holds the platform types to be used in this level so they are called/load at the same time
@onready var packed_platforms = [
	preload("res://platforms/BASIC/basic_platform.tscn"),
	preload("res://platforms/BREAK/break_platform.tscn"),
	preload("res://platforms/TIMED/timed_platform.tscn")
]

#event listeners for moving between level areas 
func _on__enter_body_entered(body):
	if body.name == "player":
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

# Called when the node enters the scene tree for the first time.
func _ready():
	platforms()
	add_child(speech)
	add_child(inventory)
