extends RigidBody2D

#variables 
@onready var weight = randi_range(10,50) #randomised weight effect against the plauer's health

#event listeners 
func _on_area_2d_body_entered(body):
	if body.name == "player":
		Global.player_health -= weight
		if Global.player_health < 100:
			queue_free()
			Switcher.switch_scene("res://GO/game_over.tscn")

#main function
func _ready():
	#randomises the size of each debris point 
	scale.x = randf_range(1,4)
	scale.y = randf_range(1,4)


