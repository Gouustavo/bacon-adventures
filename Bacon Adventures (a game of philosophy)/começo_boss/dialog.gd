extends MarginContainer

@onready var text_label = $label_margin/text_label
@onready var letter_time = $letter

const MAX_WIDTH = 150

var text = ""
var letter_index = 0

var letter_timer = 0.03
var space_time = 0.06
var pontuation_time = 0.2

signal finished_displaying()

# posição do balão + ajuste fino
var target_position: Vector2 = Vector2.ZERO
var offset: Vector2 = Vector2(0, -40) # por padrão, aparece acima do NPC


func set_balloon_position(pos: Vector2, custom_offset: Vector2 = Vector2.ZERO):
	target_position = pos
	if custom_offset != Vector2.ZERO:
		offset = custom_offset


func display_text(text_to_display: String):	
	text = text_to_display
	letter_index = 0
	text_label.text = ""
	
	# largura fixa, altura ajustável
	custom_minimum_size = Vector2(MAX_WIDTH, 0)
	text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	
	_display_letter()

	await resized
	custom_minimum_size.y = size.y
	
	# coloca o balão só uma vez, na posição escolhida
	global_position = target_position + offset
	
	text_label.text = ""
	_display_letter()
	
func _ready():
	text_label.add_theme_font_size_override("font_size", 16) # muda pra 12px
	
	
func _display_letter():
	text_label.text += text[letter_index]
	letter_index += 1
	
	if letter_index >= text.length():
		finished_displaying.emit()
		return
		
	match text[letter_index]:
		"!", "?", ",", ".":
			letter_time.start(pontuation_time)
		" ":
			letter_time.start(space_time)
		_:
			letter_time.start(letter_timer)


func _on_letter_timeout():
	_display_letter()
