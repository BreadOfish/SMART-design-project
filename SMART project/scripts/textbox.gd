extends MarginContainer

@onready var label = $MarginContainer/Label;
@onready var timer = $MarginContainer/Timer;

const MAX_WIDTH = 256; #How wide the text box can get

var text = "";
var index = 0;
const SIZECONST = 2.0;
var letter_time = 0.03;

signal text_finish();

func display_text(text_to_display: String) -> void:
	text = text_to_display;
	label.text = text_to_display;
	
	await resized;
	custom_minimum_size.x = min(size.x, MAX_WIDTH);
	
	if (size.x > MAX_WIDTH):
		label.autowrap_mode = TextServer.AUTOWRAP_WORD;
		await resized;
		await resized;
		custom_maximum_size.y = size.y;
		global_position.x -= size.x / 2;
		global_position.y -= size.y + 24;
		display_letter();

func display_letter():
	label.text += text[index];
	index += 1; #Why is ++ not a thing in Godot?
	if index >= text.length():
		text_finish.emit();
		return;
	timer.start(letter_time);


func _on_timer_timeout() -> void:
	display_letter();
