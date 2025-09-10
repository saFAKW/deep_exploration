extends Node2D

#variables
@onready var audio = $AudioStreamPlayer
@onready var bgmusic = $bgmusic

#event listeners
func _on_yaz_c_pressed():
	audio.play()
	bgmusic.playing = false 
	Global.player_char = "yaz"
	Switcher.switch_scene("res://levels/L1MAIN/level_1.tscn")

func _on_dom_c_pressed():
	audio.play()
	bgmusic.playing = false
	Global.player_char = "dom"
	Switcher.switch_scene("res://levels/L1MAIN/level_1.tscn")

func _on_return_pressed():
	audio.play()
	bgmusic.playing = false
	Switcher.switch_scene("res://MENU/menu.tscn")
