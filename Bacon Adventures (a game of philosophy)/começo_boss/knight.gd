extends CharacterBody2D

var SPEED = 4000.0
const JUMP_VELOCITY = -400.0
var direction := -1

var is_hurt := false
var is_attacking := false
var facing_direction := -1  # Guarda direção atual do sprite

@onready var wall_detector := $wall_detector as RayCast2D
@onready var right_detector := $right_detector as RayCast2D
@onready var texture := $Sprite2D as Sprite2D
@onready var anim := $anim as AnimationPlayer
@onready var wall := $right_detector as RayCast2D
@onready var right := $wall_detector as RayCast2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

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
				start_attack(alvo)

		# Detecta parede e inverte direção
		if (direction == -1 and wall_detector.is_colliding()) or (direction == 1 and right_detector.is_colliding()):
			direction *= -1

		# Só atualiza o flip quando NÃO estiver atacando
		if not is_attacking:
			facing_direction = direction
			texture.flip_h = (facing_direction == -1)

		# Movimento normal
		velocity.x = direction * SPEED * delta
	
	move_and_slide()


# -------- Funções de estado --------
func take_damage() -> void:
	if is_hurt:
		return
	is_hurt = true
	is_attacking = false
	velocity = Vector2.ZERO
	anim.play("hurt")

	await anim.animation_finished
	Globals.score += 100
	queue_free()


func start_attack(alvo: Node2D) -> void:
	is_attacking = true
	velocity.x = 0
	anim.play("attack")

	# Mantém a direção atual
	texture.flip_h = (facing_direction == -1)

	# Dá knockback no player se ele tiver a função
	if alvo.has_method("take_damage"):
		var knock_dir = sign(alvo.global_position.x - global_position.x)
		var knockback = Vector2(-400 * knock_dir, -200)  # Ajuste a força como quiser
		alvo.take_damage(knockback)


	await anim.animation_finished
	is_attacking = false
	anim.play("walk")


# -------- Morte do inimigo (pisado pelo player) --------
func die() -> void:
	if is_hurt:
		return
	is_hurt = true
	is_attacking = false
	velocity = Vector2.ZERO
	anim.play("hurt")
	await anim.animation_finished
	Globals.score += 100
	queue_free()


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurt":
		is_hurt = false
		queue_free()
	elif anim_name == "attack":
		is_attacking = false
		anim.play("walk")
