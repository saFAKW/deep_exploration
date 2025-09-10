extends Sprite2D

#variables 
@onready var anim = $AnimatedSprite2D

#event listeners
func _on_area_2d_body_entered(body):
	if body.name == "player": #so only the player may collect a key 
		if Global.no_keys < 4: #ensures players only collect three keys total
			Global.no_keys +=1 #increments counter 
			for i in range(len(Global.keys)): #runs through array to check for empty slots 
				if Global.keys[i] == null:
					Global.keys[i] = Global.player_key #saves the type of key collected
					Global.collected = true #so the whole skeleton is signalled to be removed from scene
			print(Global.keys) #check for array structure 

#main function 
# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.player_key == "right":
		anim.play("right")
	else:
		anim.play("wrong")


