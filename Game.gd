extends Node

var main_menu_inst = preload("res://gui/MainMenu.tscn")
onready var pause_screen = preload("res://gui/PauseScreen.tscn").instance()

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

func load_scene(node: Node):
	for child in get_children():
		remove_child(child)
		child.queue_free()
	add_child(node)
	get_tree().paused = false
	pass