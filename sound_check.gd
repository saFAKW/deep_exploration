extends Node2D

#coloured bars 
@onready var green = $green
@onready var yellow = $yellow
@onready var orange = $orange
@onready var red = $red

@onready var colours = [green, yellow, orange, red]

#label to help inform player
@onready var title = $title

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(len(colours)):
		colours[i].visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.player_sound <50:
		colours[0].visible = true
	elif Global.player_sound>100:
		colours[1].visible = true
	elif Global.player_sound>300:
		colours[2].visible = true
	elif Global.player_sound >500:
		colours[3].visible = true

