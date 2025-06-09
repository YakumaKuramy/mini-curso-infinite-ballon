extends CanvasLayer

var min_time: float = 0.0
var max_time: float = 60.0
var time_left: float = max_time
var displayed_time: float = 10.0
var time_since_last_pop: float = 0.0

var menu_path: String = "res://scenes/system/menu.tscn"

@onready var progress_bar: TextureProgressBar = %progress_bar
@onready var buttons: VBoxContainer = %buttons
@onready var lbl_game_over: Label = %lbl_game_over
@onready var lbl_score: Label = %lbl_score
@onready var button_restart_game: Button = %button_restart_game
@onready var button_back_menu: Button = %button_back_menu
@onready var balloon: TextureRect = %balloon
@onready var game: Control = %game

func _ready() -> void:
	buttons.visible = false
	button_back_menu.pivot_offset = button_back_menu.size / 2
	button_restart_game.pivot_offset = button_restart_game.size / 2


func _process(delta: float) -> void:
	#print("Tempo restante: " + str(time_left))
	#print("Tempo sem um balão ser estourado: " + str(time_since_last_pop))
	
	lbl_score.text = str(int(GameController.score))
	
	time_left -= delta
	time_left = clamp(time_left, 0, max_time)
	
	time_since_last_pop += delta
	
	animate_property(progress_bar, "value", time_left, 0.2)
	if time_left <= 0:
		game_over()
	elif time_since_last_pop >= max_time:
		game_over()


func add_time(amout: float) -> void:
	time_left += amout
	time_left = clamp(time_left, 0, 100)
	progress_bar.value = time_left
	time_since_last_pop -= amout
	time_since_last_pop = clamp(time_since_last_pop, 0.0, 60.0)


func game_over() -> void:
	buttons.visible = true
	game.mouse_filter = Control.MOUSE_FILTER_STOP


func _on_button_restart_game_pressed() -> void:
	TransitionScreen.restart_game()
	use_tween(button_restart_game, "scale", Vector2(1, 1), Vector2(0.9, 0.9), 0.1)
	game.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _on_button_back_menu_pressed() -> void:
	TransitionScreen.target_path = menu_path
	TransitionScreen.transition_screen()
	use_tween(button_back_menu, "scale", Vector2(1, 1), Vector2(0.9, 0.9), 0.1)


func animate_property(object: Object, property: NodePath, to_value: Variant, duration: float) -> void:
	var _tween: Tween = get_tree().create_tween()
	_tween.tween_property(object, property, to_value, duration)


func use_tween(object : Object, property: NodePath, inicial_val: Variant, final_val: Variant, duration: float) -> void:
	tween(object, property, final_val, duration)
	await get_tree().create_timer(0.1).timeout
	tween(object, property, inicial_val, duration)


func tween(object: Object, property: NodePath, final_val: Variant, duration: float) -> void:
	var _tween : Tween = get_tree().create_tween()
	_tween.tween_property(object, property, final_val, duration)
