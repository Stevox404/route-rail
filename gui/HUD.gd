extends Control

onready var hover_sound = $HoverSound


func _on_Btn_focus_entered():
	hover_sound.play()