extends CharacterBody2D

var SPEED = 2000.0
const JUMP_VELOCITY = -400.0
var direction := -1

var is_hurt := false
var is_attacking := false

@onready var wall_detector := $wall_detector as RayCast2D
@onready var right_detector := $right_detector as RayCast2D
@onready var texture := $Sprite2D as Sprite2D
@onready var anim := $anim as AnimationPlayer
@onready var wall := $right_detector as RayCast2D
@onready var right := $wall_detector as RayCast2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Se estiver machucado ou atacando, não anda
	if is_hurt or is_attacking:
		velocity.x = 0
	else:
		# Detecta colisão com player e inicia ataque
		if wall.is_colliding() or right.is_colliding():
			var alvo = null
			if wall.is_colliding():
				alvo = wall.get_collider()
			elif right.is_colliding():
				alvo = right.get_collider()
			
			if alvo != null and alvo.is_in_group("player") and not is_attacking:
				start_attack()
		

		# Detecta parede e inverte direção
		if (direction == -1 and wall_detector.is_colliding()) or (direction == 1 and right_detector.is_colliding()):
			direction *= -1  

		# Espelha sprite
		texture.flip_h = (direction == 1)

		# Movimento normal
		velocity.x = direction * SPEED * delta
	
	move_and_slide()

# -------- Funções de estado --------
func take_damage() -> void:
	if not is_hurt:
		is_hurt = true
		velocity.x = 0
		anim.play("hurt")

func attack():
	if not is_attacking:
		is_attacking = true
		anim.play("attack")
		velocity.x = 0  # Para de se mover

		await anim.animation_finished
		is_attacking = false



func start_attack() -> void:
	is_attacking = true
	velocity.x = 0
	anim.play("attack")

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurt":
		is_hurt = false
		Globals.score += 100
		queue_free()
		
	elif anim_name == "attack":
		is_attacking = false
		anim.play("walk")
