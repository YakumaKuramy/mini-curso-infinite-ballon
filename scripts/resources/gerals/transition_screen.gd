extends CanvasLayer

var target_path: String

@onready var animation: AnimationPlayer = $animation

func transition_screen() -> void:
	animation.play("fade_in")


func restart_game() -> void:
	animation.play("restart_game")


func exit_game() -> void:
	animation.play("exit_game")


func _on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"fade_in":
			get_tree().change_scene_to_file(target_path)
			animation.play("fade_out")
		"restart_game":
			get_tree().reload_current_scene()
			animation.play("fade_out")
		"exit_game":
			get_tree().quit()
