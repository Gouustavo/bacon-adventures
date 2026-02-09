extends Node2D

const WAIT_DURATION := 1.0
@onready var platform := $platform
@export var move_speed := 8.0
@export var distance := 192

enum Direction { CIMA, BAIXO, ESQUERDA, DIREITA }
@export var movement_direction: Direction = Direction.ESQUERDA

var follow := Vector2.ZERO
var start_position := Vector2.ZERO

func _ready() -> void:
	start_position = platform.position
	move_platform()

func _physics_process(delta: float) -> void:
	platform.position = platform.position.lerp(follow, 0.5)

func move_platform():
	var dir_vector := get_direction_vector()
	var move_vector = dir_vector * distance
	var duration = move_vector.length() / float(move_speed)

	var platform_tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	platform_tween.tween_property(self, "follow", start_position + move_vector, duration).set_delay(WAIT_DURATION)
	platform_tween.tween_property(self, "follow", start_position, duration).set_delay(WAIT_DURATION)

func get_direction_vector() -> Vector2:
	match movement_direction:
		Direction.CIMA:
			return Vector2.UP
		Direction.BAIXO:
			return Vector2.DOWN
		Direction.ESQUERDA:
			return Vector2.LEFT
		Direction.DIREITA:
			return Vector2.RIGHT
		_:
			return Vector2.ZERO
