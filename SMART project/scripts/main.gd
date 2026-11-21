extends Node2D


@onready var sprite = $AnimatedSprite2D
@onready var wander_timer: Timer = $WanderTimer
var wanderTo;
var screenLim;
var window;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Get the Windows window
	window = get_window();
	window.transparent_bg = true;
	window.transparent = true;
	window.borderless = true;
	window.always_on_top = true;
	window.unresizable = false;
	window.transient = false;
	
	var screen = window.current_screen;
	var pos = DisplayServer.screen_get_usable_rect(screen);
	window.position = pos.position + pos.size - window.size;
	screenLim = window.size;
	set_process_input(true);

func _process(delta) -> void:
	match ModeManager.getMode():
		ModeManager.modes.DEFAULT:
			pass;
		ModeManager.modes.WANDER:
			_wanderMode();

func _wanderMode() -> void:
	#If wanderTo is null or we went to the position, generate a new wander point
	if(wanderTo == null || window.position == wanderTo):
		wanderTo = Vector2i(randi_range(0, screenLim.x), randi_range(0, screenLim.y));
	window.position.x += sign(wanderTo.x - window.position.x);
	window.position.y += sign(wanderTo.y - window.position.y);
