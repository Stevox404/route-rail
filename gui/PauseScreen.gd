extends CanvasLayer

onready var hover_sound = $HoverSound


func _on_Btn_focus_entered():
	hover_sound.play()

func _on_ResumeBtn_pressed():
	var root = global.get_game_node(get_tree())
	if root:
		root.resume_game()

func _on_MainBtn_pressed():
	var root = global.get_game_node(get_tree())
	if root:
		root.go_to_main_menu()
