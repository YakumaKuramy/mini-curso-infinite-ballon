extends Area2D

@export var speed: float = 100.0

@onready var texture: Sprite2D = $texture
@onready var collision: CollisionShape2D = $collision

var texture_weights: Array[float] = [80.0, 10.0, 5.0, 2.5, 2.5]
var textures: Array[String] = [
	"res://assets/sprite/ballons/sprite_balloon_01.png",
	"res://assets/sprite/ballons/sprite_balloon_02.png",
	"res://assets/sprite/ballons/sprite_balloon_03.png",
	"res://assets/sprite/ballons/sprite_balloon_04.png",
	"res://assets/sprite/ballons/sprite_balloon_05.png", ]


func _ready() -> void:
	randomize()
	var red = randf_range(0.3, 1.0)
	var green = randf_range(0.3, 1.0)
	var blue = randf_range(0.3, 1.0)
	texture.modulate = Color(red, green, blue)


func _process(delta: float) -> void:
	position.y -= speed * delta
	
	if position.y < -100:
		queue_free()
