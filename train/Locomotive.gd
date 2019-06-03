extends Node

signal has_stopped_moving (reason)

enum reason {crashed}
enum dir_pnts {N, E, W, S}

export (dir_pnts) var dir setget ,get_dir
var map: TileMap
onready var train_engine = $Engine
onready var chug_sound = $ChugSound

func _enter_tree():
	print(dir)
	map = get_parent()
	if map == null or !(map is TileMap):
		GDError.new("Locomotive must be child of TileMap!", true)

func _ready():
	train_engine.connect("has_stopped", self, "_on_train_engine_has_stopped")
	chug_sound.play()
	pass

func get_dir() -> Vector2:
	match dir:
		dir_pnts.N: 
			return global.dir.N
		dir_pnts.E: 
			return global.dir.E
		dir_pnts.W: 
			return global.dir.W
		dir_pnts.S: 
			return global.dir.S
		_:
			return global.dir.E

func _on_train_engine_has_stopped(why := reason.crashed):
	emit_signal("has_stopped_moving", why)
	chug_sound.stop()



func _on_WhistleTimer_timeout():
	$WhistleTimer.wait_time = randi()%20 + 30
	$Whistle.play()
	pass # Replace with function body.
