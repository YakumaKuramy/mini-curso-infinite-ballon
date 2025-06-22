extends Area2D

@export var speed: float = 100.0

@onready var texture: Sprite2D = $texture
@onready var animation: AnimationPlayer = $animation
@onready var collision: CollisionShape2D = $collision
@onready var exploding: AudioStreamPlayer2D = $exploding
@onready var game: Control = get_tree().get_root().get_node_or_null("/root/game")
@onready var hud: CanvasLayer = get_tree().get_root().get_node_or_null("/root/game/HUD")

var texture_weights: Array[float] = [80.0, 10.0, 5.0, 2.5, 2.5]
var textures: Array[String] = [
	"res://assets/sprite/ballons/sprite_balloon_01.png",
	"res://assets/sprite/ballons/sprite_balloon_02.png",
	"res://assets/sprite/ballons/sprite_balloon_03.png",
	"res://assets/sprite/ballons/sprite_balloon_04.png",
	"res://assets/sprite/ballons/sprite_balloon_05.png", ]

var value: int = 1
var scale_tween: Tween

func _ready() -> void:
	randomize()
	
	#var texture_path = textures.pick_random()
	#texture.texture = load(texture_path)
	
	var red = randf_range(0.3, 1.0)
	var green = randf_range(0.3, 1.0)
	var blue = randf_range(0.3, 1.0)
	texture.modulate = Color(red, green, blue)
	
	animate_pop_effect()


func _process(delta: float) -> void:
	position.y -= speed * delta
	
	if position.y < -200:
		if scale_tween:
			scale_tween.kill()
		queue_free()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventScreenTouch and event.pressed):
		GameController.score += value
		SaveGame.save_data["score"] = value
		SaveGame.save_game()
		animation.play("burst")
		hud.add_time(5)
		exploding.play()
		
		if scale_tween:
			scale_tween.kill()
	
		await animation.animation_finished
		collision.set_deferred("disabled", true)
		queue_free()


func animate_pop_effect():
	scale_tween = get_tree().create_tween()
	scale_tween.set_loops()  # loop infinito
	scale_tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	scale_tween.tween_property(self, "scale", Vector2(0.8, 0.8), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
