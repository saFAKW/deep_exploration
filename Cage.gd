extends Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.saved == true:
		queue_free()

func _on_button_pressed():
	Switcher.switch_scene("res://levels/L4MAIN/key_holes.tscn")

