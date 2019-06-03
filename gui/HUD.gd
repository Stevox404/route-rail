extends Control

onready var hover_sound = $HoverSound
onready var completion_popup = $Completion

const y_pos_show = 140
const y_pos_hide = -500

var tween = Tween.new()

func _ready():
	add_child(tween)
	hide_level_complete()

func show_level_complete(success := true):
	var txt
	if success:
		txt = "SUCCESS! :)"
	else:
		txt = "FAILED :("
	completion_popup.get_child(0).text = txt
	var old_pos = completion_popup.rect_position
	var new_pos = Vector2(old_pos.x, y_pos_show)
	tween.interpolate_property(completion_popup, "rect_position", old_pos, new_pos, 1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()

func hide_level_complete():
	var old_pos = completion_popup.rect_position
	var new_pos = Vector2(old_pos.x, y_pos_hide)
#	tween.interpolate_property(completion_popup, "rect_position", old_pos, new_pos, .5,Tween.TRANS_LINEAR,Tween.EASE_IN)
#	tween.start()
	completion_popup.rect_position = new_pos

func _on_Btn_focus_entered():
	hover_sound.play()

func _on_PauseBtn_pressed():
	global.get_game_node(get_tree()).pause_game()
