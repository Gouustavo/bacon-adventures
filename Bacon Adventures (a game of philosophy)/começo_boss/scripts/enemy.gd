extends CharacterBody2D

const SPEED = 50.0
const JUMP_VELOCITY = -400.0
var direction := -1

@onready var wall_detector := $wall_detector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var animation := $anim as AnimationPlayer

# Renomeando para evitar conflito com o método nativo
func get_custom_gravity() -> float:
	return ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Aplicando a gravidade no eixo Y
	if not is_on_floor():
		velocity.y += get_custom_gravity() * delta  # <<< USANDO A FUNÇÃO RENOMEADA

	# Verifica colisão com parede e inverte a direção
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1

	# Ajustando a sprite para virar corretamente
	texture.flip_h = direction == 1

	# Movimentação
	velocity.x = direction * SPEED

	# Aplica o movimento
	move_and_slide()
