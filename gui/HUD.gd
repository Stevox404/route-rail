extends Control

onready var hover_sound = $HoverSound
onready var completion_popup = $Completion
onready var victory_sound = $VictorySound
onready var next_lvl_btn = $Completion/NextLevelBtn
onready var retry_btn = $Completion/RetryBtn

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
		next_lvl_btn.visible = true
		retry_btn.visible = true
	else:
		txt = "FAILED :("
		next_lvl_btn.visible = false
		retry_btn.visible = true
	completion_popup.get_child(0).text = txt
	completion_popup.visible = true
	var old_pos = completion_popup.rect_position
	var new_pos = Vector2(old_pos.x, y_pos_show)
	victory_sound.play()
	tween.interpolate_property(completion_popup, "rect_position", old_pos, new_pos, 1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()
#	completion_popup.rect_position = new_pos
	

func hide_level_complete():
	var old_pos = completion_popup.rect_position
	var new_pos = Vector2(old_pos.x, y_pos_hide)
	completion_popup.rect_position = new_pos
	completion_popup.visible = false

func _on_Btn_focus_entered():
	hover_sound.play()

func _on_PauseBtn_pressed():
	var root = global.get_game_node(get_tree())
	if root:
		root.pause_game()


func _on_NextLevelBtn_pressed():
	var root = global.get_game_node(get_tree())
	if root:
		root.go_to_next_level()
	pass # Replace with function body.


func _on_RetryBtn_pressed():
	var root = global.get_game_node(get_tree())
	if root:
		root.retry_level()
	pass # Replace with function body.



func _on_FFBtn_button_down():
	var parent = get_parent()
	if parent.has_user_signal("speed_up"):
		parent.emit_signal("speed_up")
	pass # Replace with function body.


func _on_FFBtn_button_up():
	var parent = get_parent();
	if 	parent.has_user_signal("slow_down"):
		parent.emit_signal("slow_down")
	pass # Replace with function body.
