extends Node

var main_menu_inst = preload("res://gui/MainMenu.tscn")
var pause_screen = preload("res://gui/PauseScreen.tscn").instance()

const lvls = {
	lvl1 = preload('res://levels/Level1.tscn'),
	lvl2 = preload('res://levels/Level2.tscn'),
	lvl3 = preload('res://levels/Level3.tscn'),
	lvl4 = preload('res://levels/Level4.tscn'),
	lvl5 = preload('res://levels/Level5.tscn'),
}

func pause_game():
	get_tree().paused = true
#	load_scene(pause_screen)
#	add_child_below_node(pause_screen, get_child(0))
	add_child(pause_screen)

func resume_game():
	get_tree().paused = false
	remove_child(pause_screen)

func go_to_main_menu():
	load_scene(main_menu_inst.instance())

func go_to_next_level():
	for child in get_children():
		if child.has_method("get_next_level"):
			var next_level = lvls["lvl%d" % child.get_next_level()]
			print("Going to next level", next_level) 
			load_scene(next_level.instance())
			break
	pass

func retry_level():
	for child in get_children():
		if child.has_method("get_next_level"):
			var this_level = lvls["lvl%d" % (child.get_next_level()-1)]
			print("Retrying level", this_level) 
			load_scene(this_level.instance())
			break
	pass

func show_level_completion(success: bool):
	for child in get_children():
		if child.has_method("handle_level_completion"):
			child.handle_level_completion(success)
			break
	pass

func load_scene(node: Node):
	for child in get_children():
		remove_child(child)
		child.queue_free()
	add_child(node)
	get_tree().paused = false
	pass