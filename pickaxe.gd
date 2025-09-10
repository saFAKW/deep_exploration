extends RigidBody2D

const GRAVITY = 10

@onready var pickaxe = $pickaxe_sprite
@onready var velocity_r = Vector2(1,0)
@onready var velocity_l = Vector2(-1,0)
@onready var speed = 1000

@onready var sheath = $sheath

#self made functions 
func collision_response(collide):
		if collide != null: #checks for ingame collisions based on timing or collisions
			speed = 0
			sheath.play()
			queue_free()
			
func collision_check(direction,delta):
	var collide = move_and_collide(direction*delta*speed)
	return collide 

#main function
func _physics_process(delta):
	#monitors the node until collision is detected 
	$pickaxe_sprite.rotation += 3
	if Global.player_rl == "r":
		collision_response(collision_check(velocity_r,delta))
	else:
		collision_response(collision_check(velocity_l,delta))
	
	

