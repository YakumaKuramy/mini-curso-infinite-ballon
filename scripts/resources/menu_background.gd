extends ParallaxBackground

@export var direction :Vector2
@export var speed :float

@onready var parallax_layer: ParallaxLayer = $layer
@onready var background: TextureRect = $layer/texture

func _ready() -> void:
	print("Tamanho da Textura: ", background.size)
	print("Tamanho da viewport: ", get_viewport().size)


func _process(delta: float) -> void:
	parallax_layer.motion_offset += direction * delta * speed
