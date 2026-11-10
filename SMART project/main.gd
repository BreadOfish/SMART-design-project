extends Node2D
const TEST_DIALOGUE:  Array[String]  = [
	"Hello world!",
	"This is a test dialog box!",
	"Lorum Ipsum",
	"Ballsack"
];

@onready var sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Get the Windows window
	var window = get_window();
	window.transparent_bg = true;
	window.transparent = true;
	window.borderless = true;
	window.always_on_top = true;
	window.unresizable = false;
	window.transient = false;
	
	var screen = window.current_screen;
	var pos = DisplayServer.screen_get_usable_rect(	screen);
	window.position = pos.position + pos.size - window.size;
	test();

func test():
	DialogueManager.start_dialog(sprite.global_position, TEST_DIALOGUE);
