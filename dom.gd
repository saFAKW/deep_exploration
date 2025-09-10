extends Sprite2D

#variables
@onready var anim = $dom_anim
@onready var marker_r = $pickaxe_marker
@onready var marker_l = $pickaxe_markerl

#what type of character the sprite is set to
@onready var friend = false #who the user is saving 
@onready var user = false #who the user is playing as

#self made functions 
#bomb instantion and intergration
func pickaxe_maker(marker, pickaxe):
	anim.play("Throw")
	pickaxe.get_parent()
	pickaxe.position = marker.position #sets the bombs coordinates to sync with the marker node
	add_child(pickaxe) #adds child "pickaxe" which holds the bomb scene to the main tree "dom"

#canvas flipping and direction control based on player inputs/events
func directions():
		var direction_X = Input.get_axis("ui_left", "ui_right")
		if direction_X > 0: #checks for which way the coordinates change 
			anim.flip_h = false 
		else:
			anim.flip_h = true #flips animated canvas as original image works in one direction not the other
		anim.play("Run")

#main function
#PLAYER ACTIONS
func _process(_delta):
	if Global.player_char == "dom" or friend == true: #this is so the same commands can be shared
		user = true
		#resting position
		anim.play("Stance")
		#jumping
		if Input.is_action_pressed("ui_up"): #condition runs code until key release
			anim.play("Jump")
		#move left or right
		elif Input.get_axis("ui_left", "ui_right"):
			directions()
		#throwing condition
		elif Input.is_action_pressed("ui_focus_next"):
			anim.play("Throw")
		elif Input.is_action_just_released("ui_focus_next") and Global.pickaxe == true:
			var pickaxe = preload("res://characters/DOM/pickaxe_moves.tscn").instantiate()
			#assigns the correct point to be instantiated so it moves in the right direction
			if anim.flip_h == true: #this changes whenever the left or right arrow is pressed
				Global.player_rl = "l" #sets the global variable to the correct facing side
				pickaxe_maker(marker_l, pickaxe)
			else:
				Global.player_rl = "r"
				pickaxe_maker(marker_r, pickaxe)
	else:
		anim.play("Stance")
		if Global.saved == true:
			friend = true 
			
		
		
