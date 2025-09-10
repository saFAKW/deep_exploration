extends Node2D

#button event listeners (run automatically)
func _on_retry_pressed():
	#accesses the checkpoint array to update all inventory to the data last stored within 
	Global.player_char = Global.record[0]
	Global.player_pos = Global.record[1] #this sends the player back to level 3
	Global.player_score = Global.record[2] #this resets thescore to what it previously was
	Global.player_health = Global.record[3] #this resets health 
	get_tree().change_scene_to_file("res://levels/L3MAIN/level_3.tscn")

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://MENU/menu.tscn")

func _ready():
	#initially sets the checkpoint flag to false so players cannot retry if they die
	$retry.visible = false 

func _process(_delta):
	#checks if the record chekcpoint updates has data within it
	if Global.record[0] != null: #this proves the player has interacted with the checkpoint
		$retry.visible = true


