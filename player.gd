extends CharacterBody2D

#constants
const GRAVITY = 10
const JUMP_SPEED = -500 #-ve as down means up in games
const RUN_SPEED = 300

#variables
#instantiate all charatcers set for the first level dependent on the player choice
@onready var yaz = preload("res://characters/YAZ/yaz_moves.tscn").instantiate()
@onready var dom = preload("res://characters/DOM/dom_moves.tscn").instantiate()

#movement monitoring 
@onready var jump = false 
@onready var run = false 
@onready var stand = false 

#powerup checker 
@onready var flashlight_in = false #these will change when the player has access to said powerups within the game 
@onready var hardhat_in = false

#powerup set ups 
@onready var flashlight = $flashlight
@onready var hardhat = $hardhat

#sound effects
@onready var gem = $gem #collection noise

#event listeners
func _on_gem_checker_body_entered(body):
	if body.name == "gem":
		gem.play()

func _on_hardhat_body_entered(body):
	if body.name == "debris": 
		Global.hardhat_power -= 10
		if Global.hardhat_power == 0:
			Global.player_powerup = null

#self made functions 
#powerups 
func powerup_checks():
	if Global.player_powerup == null:
		flashlight.energy = 0 #sets the light intensity to zero intially
		hardhat.visible = false #removes the extra collision detection protecting the character 
	elif Global.player_powerup == "flashlight":
		flashlight.energy = Global.flashlight_power #updates light node
	elif Global.player_powerup == "hardhat":
		hardhat.visible = true
		$hardhat2.visible = true
	else:
		pass

func char_choice():
	if Global.player_char == "yaz": #loads the corresponding char they picked previously
		yaz.get_parent()
		yaz.position = $spawn_point.position #sets the bombs coordinates to sync with the marker node
		add_child(yaz) #adds child "instance" which holds the bomb scene to the main tree "yaz"
	else:
		dom.get_parent()
		dom.position = $spawn_point.position #sets the bombs coordinates to sync with the marker node
		add_child(dom) #adds child "instance" which holds the bomb scene to the main tree "yaz"

#monitors the player movements so sound variable can increment
func sound_checks():
	if Global.player_pos == "LEVEL -2":
		if Global.player_sound <= 700: #ensures it only increments when the player is on the correct level
			await get_tree().create_timer(5).timeout #cool down to slow down the rate of increment
			print(Global.player_sound) #check for proper updates
			if jump == true: #based on the action the boolean flag will increment the sound level
				Global.player_sound += 5
			elif run == true:
				Global.player_sound += 20
			else:
				Global.player_sound -= 10
	else:
		pass

#main functions
func _ready(): #called when the node enters the scene tree for the first time
	hardhat.visible = false
	$hardhat2.visible = false
	char_choice() #sets up the player's choice from previous scene 

func _process(_delta):
	powerup_checks()
	sound_checks()

#PLAYER ACTIONS
func _physics_process(_delta):
	#intiates gravity into the environment
	velocity.y += GRAVITY 
	#jumping
	if Input.is_action_pressed("ui_up"): #condition runs code until key release
		if is_on_floor():
			jump = true
			velocity.y = JUMP_SPEED #to slow down the jump to prevent player going off screen
	#move left or right
	elif Input.get_axis("ui_left", "ui_right"):
		run = true
		var direction_X = Input.get_axis("ui_left", "ui_right")
		velocity.x = RUN_SPEED*direction_X
	#resting position
	else: 
		velocity.x = move_toward(velocity.x, 0, RUN_SPEED) 
		run = false
		jump = false
	
	move_and_slide() #initiates sprite movement

