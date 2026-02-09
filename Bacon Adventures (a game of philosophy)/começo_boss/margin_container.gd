extends MarginContainer


@onready var label1 = $MarginContainer/Label
@onready var timer1 = $Timer


const MAX_WIDTH = 256

var text = ""
var letter_index = 0

var letter_timer = 0.03
var space_time = 0.06
var pontuation_time = 0.2


signal finished_displaying()


func display_text(text_to_display: String):	
	text = text_to_display
	label1.text = text_to_display
	
	letter_index = 0 # <-- Reinicia para cada nova fala
	label1.text = ""
	
	_display_letter()
	
	await  resized #//quando o tamanho da caixa da próxima mensagem é igual ele trava tudo o que está para baixo e com isso não atualiza para a próxima mensagem, não avança e a posição da caixa se desloca e não é criada no local desejado.
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label1.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
		
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	
	label1.text = ""
	_display_letter()
	
	
func _display_letter():
	label1.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
		
	match text[letter_index]:
		"!", "?", ",", ".":
			timer1.start(pontuation_time)
		" ":
			timer1.start(space_time)
		_:
			timer1.start(letter_timer)
			
func _on_timer_timeout() -> void:
	_display_letter()
