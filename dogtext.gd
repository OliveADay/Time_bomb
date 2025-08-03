extends Label
@export var speed = 3
@export var font_size_change_interval = 0.1
var current_interval = 0
var rng
var font_size = 7


func _ready() -> void:
	rng = RandomNumberGenerator.new()
	current_interval = font_size_change_interval

func _process(delta: float) -> void:
	position.x += delta*speed
	position.y -= delta*speed
	position.y -= delta*speed*rng.randf_range(-0.8,1)
	if current_interval > 0:
		current_interval -= delta
	elif font_size > 0:
		add_theme_font_size_override("font_size", font_size)
		if font_size > 2:
			font_size -= 1
		else:
			font_size -= 2
		current_interval = font_size_change_interval
	else:
		font_size = 8
		position = Vector2(2,-6)
		add_theme_font_size_override("font_size", font_size)
