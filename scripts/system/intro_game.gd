extends Control

var menu_path: String = "res://scenes/system/menu.tscn"

func _ready() -> void:
	await get_tree().create_timer(5).timeout
	TransitionScreen.target_path = menu_path
	TransitionScreen.transition_screen()
