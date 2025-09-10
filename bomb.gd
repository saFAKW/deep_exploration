extends RigidBody2D

#constants 
const GRAVITY = 10

#variables
@onready var anim_b = $bomb_anim
@onready var velocity_r = Vector2(1,0)
@onready var velocity_l = Vector2(-1,0)
@onready var speed = 1000

#self made functions 
func collision_response(collide):
		if collide != null: #checks for ingame collisions based on timing or collisions
			speed = 0
			anim_b.play("Active")

func collision_check(direction,delta):
	var collide = move_and_collide(direction*delta*speed)
	return collide 

#main function
func _physics_process(delta):
	print("bomb made")
	anim_b.play("Stable")
	#monitors the node until collision is detected 
	if Global.player_rl == "r":
		collision_response(collision_check(velocity_r,delta))
	else:
		collision_response(collision_check(velocity_l,delta))

