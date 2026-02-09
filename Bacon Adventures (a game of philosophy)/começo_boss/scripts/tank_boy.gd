extends CharacterBody2D

const SPEED = 5000.0
var direction = -1
const JUMP_VELOCITY = -400.0

@onready var wall_detector: RayCast2D = $wall_detector
@onready var sprite: Sprite2D = $Sprite

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1

	if direction == 1:
		velocity.x = delta * SPEED
		sprite.flip_h = true
	else:
		velocity.x = delta * -SPEED
		sprite.flip_h = false
		
	move_and_slide()
	
