extends Node

@onready var text_box_scene = preload("res://scenes/textbox.tscn");

var dialog_line: Array[String] = [];
var line_index: int = 0;

var text_box;
var text_box_pos: Vector2;

var is_dialog_active: bool = false;
var can_advance_line:bool = false;

func start_dialog(position: Vector2, lines: Array[String]) -> void:
	if is_dialog_active:
		return;
	dialog_line = lines;
	text_box_pos = position;
	show_textbox();
	
	is_dialog_active = true;
	
func show_textbox():
	text_box = text_box_scene.instantiate();
	text_box.text_finish.connect(on_text_box_finish);
	get_tree().root.add_child.call_deferred(text_box);
	text_box.global_position = text_box_pos;
	text_box.display_text(dialog_line[line_index]);
	
func on_text_box_finish(event):
	if(event.is_action_pressed("advance_dialog") && can_advance_line && is_dialog_active):
		text_box.queue_free();
		line_index += 1;
		if (line_index >= dialog_line.size()):
			is_dialog_active = false;
			line_index = 0;
			return;
		show_textbox();
