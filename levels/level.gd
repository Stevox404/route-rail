extends Node

export (int) var level = 1
onready var hud = $HUD
onready var train = $TileMap/Locomotive

signal speed_up
signal slow_down

func _ready():
	connect("speed_up", train, "on_train_speed_up")
	connect("slow_down", train, "on_train_slow_down")
	pass

func handle_level_completion(success: bool):
	hud.show_level_complete(success)
	pass

func get_next_level():
	return level+1