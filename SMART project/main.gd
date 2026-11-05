extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Get the Windows window
	var window = get_window();
	window.transparent_bg = true;
	window.transparent = true;
	window.borderless = true;
	window.always_on_top = true;
	window.unresizable = false;
	
