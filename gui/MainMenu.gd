extends Control

onready var hover_sound = $HoverSound
onready var level1 = preload("res://levels/Level1.tscn").instance()


func _on_Btn_focus_entered():
	hover_sound.play()

func _on_StartBtn_pressed():
	var root = global.get_game_node(get_tree())
	if root:
		root.load_scene(level1)

func _on_CloseBtn_pressed():
	global.quit_game()