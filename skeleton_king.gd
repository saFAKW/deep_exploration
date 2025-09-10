extends CharacterBody2D

#variables
#body parts
@onready var king_arm = $KingArm
@onready var king_arm_2 = $KingArm2
@onready var king_head = $KingHead

#eye lights
@onready var light_l = $light_l
@onready var light_r = $light_r

#main function
func _ready():
	light_l.energy = 0.0
	light_r.energy = 0.0

func _process(_delta):
	if Global.player_sound > 50:
		#one eye lit to act as awarning of sound detection
		light_l.energy = 2 #max light intensity
	if Global.player_sound >= 600:
	#both eyes light up to indicate the king has awoken
		light_r.energy = 2
		await get_tree().create_timer(10)
		Switcher.switch_scene("res://GO/game_over.tscn")


