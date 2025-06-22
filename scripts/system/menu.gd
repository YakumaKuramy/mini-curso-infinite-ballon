extends Control

@onready var button_play: Button = %button_play
@onready var lbl_score: Label = %lbl_score


var game_path: String = "res://scenes/game_scene/game.tscn"

func _ready() -> void:
	button_play.pivot_offset = button_play.size / 2
	lbl_score.pivot_offset = lbl_score.size / 2


func _process(_delta: float) -> void:
	if SaveGame.save_data["score"] >= SaveGame.save_data["best_score"]:
		SaveGame.save_data["best_score"] = SaveGame.save_data["score"]
	
	lbl_score.text = str(int(SaveGame.save_data["best_score"]))


func _on_button_play_pressed() -> void:
	use_tween(button_play, "scale", Vector2(1, 1), Vector2(0.9, 0.9), 0.1)
	TransitionScreen.target_path = game_path
	TransitionScreen.transition_screen()
	Sfx.play()


func use_tween(object : Object, property: NodePath, inicial_val: Variant, final_val: Variant, duration: float) -> void:
	tween(object, property, final_val, duration)
	await get_tree().create_timer(0.1).timeout
	tween(object, property, inicial_val, duration)


func tween(object: Object, property: NodePath, final_val: Variant, duration: float) -> void:
	var _tween : Tween = get_tree().create_tween()
	_tween.tween_property(object, property, final_val, duration)
