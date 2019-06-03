extends CanvasLayer

onready var hover_sound = $HoverSound


func _on_Btn_focus_entered():
	hover_sound.play()

func _on_ResumeBtn_pressed():
	global.get_game_node(get_tree()).resume_game()

func _on_MainBtn_pressed():
	global.get_game_node(get_tree()).go_to_main_menu()
