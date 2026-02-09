extends AnimatableBody2D
@onready var anim := $anim as AnimationPlayer
@onready var respaw_timer := $respaw_timer as Timer
@onready var respaw_position :=  global_position

@export var reset_timer 	:= 3.0 

var velocity = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var foi_ativado  := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_physics_process(false)
func _physics_process(delta): 
	velocity.y += gravity * delta 
	position += velocity * delta
	

func has_collided_with(collision: KinematicCollision2D, colider: CharacterBody2D):
	if !foi_ativado:
		foi_ativado = true
		anim.play("shake")
		velocity = Vector2.ZERO


func _on_anim_animation_finished(anim_name: StringName) -> void:
		set_physics_process(true)	
		respaw_timer.start(reset_timer)


func _on_respaw_timer_timeout() -> void:
	set_physics_process(false)
	global_position = respaw_position
	if foi_ativado:
		var spaw_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		spaw_tween.tween_property($texture, "scale", Vector2(1,1), 0.2).from(Vector2(0,0))
	foi_ativado = false 
