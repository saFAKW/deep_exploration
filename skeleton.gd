extends CharacterBody2D

#constants
const RUN_SPEED = 1 #handles run velocity of sprite
const JUMP_SPEED = 300 #handles jump power of sprite 
const GRAVITY = 10

#variables
#boolean collision responses 
@onready var player = false

@onready var jump = false
@onready var no_jumps = 0

@onready var flip = false

@onready var weight = 200

#handles animation qualities 
@onready var anim = $skel_anim
@onready var right_key = $keys/RightKey
@onready var wrong_key = $keys/WrongKey
@onready var keys = $keys

#handles/monitors the direction of velocity 
@onready var skel_rl = ""
@onready var dead = $death
@onready var roaring = $roaring

@onready var general = ["boundary", "skeleton", "gem"]
@onready var platforms = ["break", "timed", "basic"]

#event listeners
func _on_skel_rad_body_entered(body):
	if body.name == "player":
		player = true
		if keys.visible == true:
			queue_free()
		else:
			Global.player_health -= 20 #affects player health
	elif body.name == "bomb" or body.name == "pickaxe":
		weight -= 20
		if weight == 0:
			death()
	else:
		for i in range(len(general)):
			if body.name == general[i]:
				flip = true
				flip_skel(skel_rl)
			elif body.name == platforms[i]:
				jump = true 

#self made functions
func randomiser(): #random number generator to give variety into skeleton movement
	var num = randi_range(1,2)
	return num

func player_follow(state): #delta is to ensure smooth travel 
	if state == true:
		anim.play("Fight") 
		if Global.player_rl == "l": #flips canvas to match the player
			skel_rl = "l"
		else: #this means the player has moved right
			skel_rl = "r"

func flip_skel(direction):
	roaring.play()
	anim.flip_h = true
	if direction == "r":
		skel_rl =  "l"
	else:
		skel_rl = "r"
	flip = false

func death():
	dead.play()
	Global.enemy_change()
	anim.visible = false #to remove active skins and highlight key
	$skel_coll.visible = false
	velocity.x = 0 #to stop movement
	keys.visible = true
	if randomiser() == 1:
		wrong_key.visible = true
		Global.player_key = "wrong"
	else:
		right_key.visible = true
		Global.player_key = "right"

#main functions 
#intial set up of direction for the enemies
func _ready():
	anim.play("Stance")
	keys.visible = false
	
	if randomiser() == 1: #uses the randomiser to determine an intial direction
		skel_rl = "l"
		anim.flip_h = true
	else:
		skel_rl = "r"

#ENEMY ACTIONS
func _physics_process(_delta):
	#intiates gravity into skeleton
	velocity.y += GRAVITY 
	if jump == true:
		if no_jumps < 4:
			if is_on_floor():
				velocity.y -= JUMP_SPEED
				no_jumps += 1
		else:
			jump = false
			no_jumps = 0
				
	elif skel_rl == "r":
		velocity.x += RUN_SPEED
	elif skel_rl == "l":
		velocity.x += (RUN_SPEED*-1)
	player_follow(player) #takes player as boolean parameter to check for interaction 
	#initiates sprite movement
	move_and_slide()

