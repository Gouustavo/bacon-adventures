extends Area2D

# Sinal de dano
signal player_damaged(amount)

# Valor do dano
@export var damage: int = 10  # Quantidade de dano que os espinhos causam

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.name == "player" && body.has_method("take_damage"):
		body.take_damage(Vector2(0, -250))
