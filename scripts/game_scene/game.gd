extends Control

@onready var spawner_position: Marker2D = $spawner_position
@onready var progress_bar: TextureProgressBar = %progress_bar
@onready var lbl_game_over: Label = %lbl_game_over
@onready var ballon: PackedScene = preload("res://scenes/resources/balloon.tscn")

var min_value: float = 0.0
var max_value: float = 100.0
var time_left: float = 100.0


func _ready() -> void:
	randomize()
	lbl_game_over.visible = false


func _process(delta: float) -> void:
	if time_left > 0:
		time_left -= delta
		progress_bar.value = time_left
	if time_left <= 0:
		game_over()
	print(time_left)


func add_time(amout: float) -> void:
	time_left += amout
	time_left = clamp(time_left, 0, 100)
	progress_bar.value = time_left


func game_over() -> void:
	lbl_game_over.visible = true
	print("Fim de Jogo")


func _on_spawn_timer_timeout() -> void:
	var new_balloon = ballon.instantiate()
	var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")

	var x = randi_range(50, screen_width - 50)
	var y = screen_height + 100
	
	new_balloon.position = Vector2(x, y)
	add_child(new_balloon)
