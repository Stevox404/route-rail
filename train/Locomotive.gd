extends Node

signal has_stopped_moving (reason)
signal speed_changed(increase)

enum reason {crashed, completed}
enum dir_pnts {N, E, W, S}

export (dir_pnts) var dir setget ,get_dir
var map: TileMap
onready var train_engine = $Engine
onready var chug_sound = $ChugSound
onready var train_goal_area = $Engine/TrainGoalArea

var is_at_goal  = false

func _enter_tree():
	map = get_parent()
	if map == null or !(map is TileMap):
		GDError.new("Locomotive must be child of TileMap!", true)

func _ready():
	train_engine.connect("has_stopped", self, "_on_train_engine_has_stopped")
#	$Cab.co
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
	stop_the_train(why)
	var root = global.get_game_node(get_tree())
	if root:
		root.show_level_completion(false)


func stop_the_train(why):
	emit_signal("has_stopped_moving", why)
	chug_sound.stop()
	$WhistleTimer.stop()
	pass

func on_train_speed_up():
	emit_signal("speed_changed", true)
	pass

func on_train_slow_down():
	emit_signal("speed_changed", false)
	pass

func _on_WhistleTimer_timeout():
	$WhistleTimer.wait_time = randi()%20 + 30
	$Whistle.play()
	pass # Replace with function body.


func check_goal():
	var areas = train_goal_area.get_overlapping_areas()
	if areas.size() == 0:
		return
	is_at_goal = true
	stop_the_train(reason.completed)
	var root = global.get_game_node(get_tree())
	if root:
		root.show_level_completion(true)
		pass
	pass # Replace with function body.

func _physics_process(delta):
	if !is_at_goal:
		check_goal()