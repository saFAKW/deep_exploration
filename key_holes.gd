extends Node2D

#variables
#animation callers so corresponding sprite frames are called
@onready var anim1 = $"key animation"
@onready var anim2 = $"key animation2"
@onready var anim3 = $"key animation3"

#lock boolean monitors for correct key inputs 
@onready var unlocked1 = false
@onready var unlocked2 = false
@onready var unlocked3 = false

#button node labels 
@onready var but_s_1 = $but_s1
@onready var but_s_2 = $but_s2
@onready var but_s_3 = $but_s3

#sets the global variable to a set variable for ease of access
@onready var key_list = ["right","right","right"]
@onready var counter = 0

#event listeners
func _on_return_pressed():
	queue_free()
	Switcher.switch_scene("res://levels/L4MAIN/level_4.tscn")

func _on_button_pressed(): #response to opening lock 1
	anim1.play("key")
	if counter < 3:
		if key_list[counter] == "right":
			key_list[counter] = "0" #empties the list so no other correct keys are repeatedly accepted 
			unlocked1 = true
		counter+=1
			#introduce a sound to indiciate the lock wont open 

func _on_button_2_pressed(): #response to opening lock 2
	anim2.play("key")
	if counter < 3:
		if key_list[counter] == "right":
			key_list[counter] = "1" #empties the list so no other correct keys are repeatedly accepted 
			unlocked2 = true
		counter+=1

func _on_button_3_pressed(): #response to opening lock 3
	anim3.play("key")
	if counter < 3:
		if key_list[counter] == "right":
			key_list[counter] = "2" #empties the list so no other correct keys are repeatedly accepted 
			unlocked3 = true
		counter+=1

#self made function
func checker():
	var check_list = [unlocked1,unlocked2,unlocked3]
	for i in range(len(check_list)):
		var check = check_list[i]
		if check == true:
			if i == 0:
				but_s_1.position.y += 10
				anim1.position.y += 10
			elif i == 1:
				but_s_2.position.y += 10 #makes the sprite look like it 'falls'
				anim2.position.y += 10
			elif i == 2:
				but_s_3.position.y += 10
				anim3.position.y += 10
			else:
				pass

#main functions 
# Called when the node enters the scene tree for the first time
func _ready():
	anim1.play("default")
	anim2.play("default")
	anim3.play("default")

func _process(_delta):
	if unlocked1 == true or unlocked2 == true or unlocked3 == true:
		checker() #ensures the for loop stays in sync with the separate event listeners 
	elif unlocked1 == true and unlocked2 == true and unlocked3 == true:
		Global.saved = true
		Switcher.switch_scene("res://scenes/loading.tscn")
	else:
		Global.saved = false
