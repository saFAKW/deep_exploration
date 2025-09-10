extends Node

#constants
const GEM = 10
const BREAK = 20
const ENEMY = 100
const WEAPON = 5

#player initial variables
@onready var player_health = 500
@onready var player_score = 1080
@onready var player_char = "yaz"
@onready var player_pos = null
@onready var player_weapon = null
@onready var player_powerup = ""
@onready var player_sound = 30

#retry monitoring 
@onready var record = ["yaz","Level -1",1080,500]
@onready var retry = true 

@onready var key_holes = false

@onready var player_key = null 
@onready var no_keys = 0
@onready var keys = [null,null,null]
@onready var collected = false

@onready var official_name = "SAF"

@onready var player_rl = "r"

#dom pickaxe checker
@onready var pickaxe = true
@onready var pick_no = 1

#flashlight management variables
@onready var flashlight_power = 0.81
@onready var bat_collect = false

#hardhat management variables
@onready var hardhat_power = 20

@onready var finished = false 

#NPC management
@onready var NPC_saved = true

#pause management
@onready var paused = false
@onready var paused_level = "1"

#friend saviour checks
@onready var saved = true

@onready var music_off = false 

#self made functions for in game interfaces
#score changers
func gem_change(): #increases overall score so inventory can update
	player_score += GEM #increases player score

func enemy_change(): #increases score when enemies are defeated
	player_score += 100

#end game checks
func game_over(): 
	if player_health <100: #condition monitoring player health decreases
		finished = true 
		Switcher.switch_scene("res://GO/game_over.tscn")

