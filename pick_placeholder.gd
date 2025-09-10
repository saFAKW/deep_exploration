extends Sprite2D

func _on_area_2d_body_entered(body):
	if body.name == "player" and Global.pick_no <4:
		Global.pickaxe = true
		Global.pick_no +=1
		queue_free()

