extends CharacterBody2D

const JUMP_FORCE = -300.0

@onready var jump_sfx: AudioStreamPlayer = $jump_sfx
@onready var animation: AnimatedSprite2D = $anim
@onready var remote_transform: RemoteTransform2D = $remote
@export var y_limit: float = 500.0

var direction := 0
var is_jumping := false
var is_hurted := false
var knockback_vector := Vector2.ZERO
var base_speed := 200.0
var turbo_speed := 300.0
var speed := base_speed

var health: int = 100  # Outra variável de vida, se desejar usar

signal player_has_died

func _physics_process(delta: float) -> void:
	# Adiciona gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Alterna entre velocidade normal e turbo
	if Input.is_action_pressed("velocity_two"):
		speed = turbo_speed
	else:
		speed = base_speed

	# Verifica colisões laterais (ataques dos inimigos)
	if $ray_left.is_colliding():
		var collider = $ray_left.get_collider()
		if collider and collider.has_method("attack"):
			collider.attack()
			take_damage(Vector2(200, -200))

	elif $ray_right.is_colliding():
		var collider = $ray_right.get_collider()
		if collider and collider.has_method("attack"):
			collider.attack()
			take_damage(Vector2(-200, -200))

	# Caiu fora do limite → game over
	if position.y >= y_limit:
		get_tree().change_scene_to_file("res://game_over.tscn")

	# Pulo
	if Input.is_action_just_pressed("mover_cima") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
		jump_sfx.play()
	elif is_on_floor():
		is_jumping = false

	# Movimentação horizontal
	direction = Input.get_axis("mover_esquerda", "mover_direita")
	if direction:
		velocity.x = direction * speed
		animation.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# Aplicar knockback se existir
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector

	move_and_slide()
	set_state()

	# Verifica colisões com plataformas
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)


func bounce() -> void:
	velocity.y = JUMP_FORCE * 0.8  # Pulo extra ao matar inimigo


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if $ray_left.is_colliding():
		take_damage(Vector2(200, -200))
	elif $ray_right.is_colliding():
		take_damage(Vector2(-200, -200))


func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path


func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	if Globals.player_life > 0:
		Globals.player_life -= 1
	else:
		emit_signal("player_has_died")
		queue_free()
		return

	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force

		var knockback_tween := get_tree().create_tween()
		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		animation.modulate = Color(1, 0, 0, 1)
		knockback_tween.tween_property(animation, "modulate", Color(1, 1, 1, 1), duration)

	shake_camera()  # 💥 tremor da tela quando leva dano

	is_hurted = true
	await get_tree().create_timer(0.3).timeout
	is_hurted = false


func set_state():
	var state = "idle"
	if !is_on_floor():
		state = "jump"
	elif direction != 0:
		state = "run"
	if is_hurted:
		state = "hurt"
	if animation.name != state:
		animation.play(state)


func _on_animated_sprite_2d_animation_finished() -> void:
	Globals.player_life = min(Globals.player_life + 1, 5)
	print("Vida aumentada! Agora: ", Globals.player_life)


# 🔥 Função nova: faz a tela tremer quando o player leva dano
func shake_camera(intensity := 8.0, duration := 0.2):
	var cam := get_viewport().get_camera_2d()
	if cam == null:
		return

	var tween := get_tree().create_tween()
	for i in range(10):
		var offset = Vector2(randf_range(-intensity, intensity), randf_range(-intensity, intensity))
		tween.tween_property(cam, "offset", offset, duration / 10)
	tween.tween_property(cam, "offset", Vector2.ZERO, 0.05)
