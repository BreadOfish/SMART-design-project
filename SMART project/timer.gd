extends Node2D

@onready var growing_flowers: Sprite2D = $GrowingFlowers

enum State{
	IDLE,
	RUNNING,
	PAUSED
}

enum Study_States{
	STUDY,
	BREAK
}

var state = State.IDLE;
var phase = Study_States.STUDY;

var timer: Timer
var mins: SpinBox;
var secs: SpinBox;
var display: Label;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_size(Vector2i(1000, 1000))
	
	#Create  the timer
	timer = Timer.new();
	timer.one_shot = true;
	timer.timeout.connect(_time_out);
	add_child(timer);
	
	#Set up UI
	var box = VBoxContainer.new();
	box.custom_minimum_size = Vector2(360, 0);
	box.position = Vector2(500, 250);
	box.alignment = BoxContainer.ALIGNMENT_CENTER
	add_child(box);
	
	var inputs = HBoxContainer.new();
	box.add_child(inputs);
	
	mins = _make_spinbox(999, 0);
	secs = _make_spinbox(59, 0);
	inputs.add_child(mins);
	inputs.add_child(_label("min"));
	inputs.add_child(secs);
	inputs.add_child(_label("sec"));
	
	display = Label.new();
	display.add_theme_font_size_override("font_size", 48);
	box.add_child(display);
	
	var buttons = HBoxContainer.new();
	box.add_child(buttons)
	buttons.add_child(_make_button("Start", _on_start))
	buttons.add_child(_make_button("Pause", _on_pause))
	buttons.add_child(_make_button("Stop", _on_stop))
	
	inputs.alignment = BoxContainer.ALIGNMENT_CENTER;
	buttons.alignment = BoxContainer.ALIGNMENT_CENTER;
	display.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;
	
	_show_duration()

func _process(_delta: float) -> void:
	if state != State.IDLE:
		_render(timer.time_left)
		var progress = 1.0 - timer.time_left / timer.wait_time
		growing_flowers.scale = Vector2(0.5, 0.5) * lerp(0.35, 1.0, progress);	
	else:
		growing_flowers.scale = Vector2(0.5, 0.5);
		

func _on_start() -> void:
	match state:
		State.IDLE:
			var duration := _get_duration()
			if duration <= 0:
				return
			timer.start(duration)
			state = State.RUNNING
		State.PAUSED:
			timer.paused = false
			state = State.RUNNING

func _on_pause() -> void:
	if state == State.RUNNING:
		timer.paused = true;
		state = State.PAUSED;

func _on_stop() -> void:
	timer.paused = false;
	timer.stop();
	state = State.IDLE;
	_show_duration();

func _on_timeout() -> void:
	state = State.IDLE;
	_render(0);

func _time_out():
	pass
	
func _get_duration() -> float:
	return mins.value * 60.0 + secs.value

func _show_duration() -> void:
	_render(_get_duration())

	
func _render(seconds: float) -> void:
	var total = ceili(seconds);
	display.text = "%02d:%02d" % [int(total / 60.0), total % 60];
	
func _make_spinbox(max_val: float, start_val: float) -> SpinBox:
	var spinbox = SpinBox.new();
	spinbox.min_value = 0;
	spinbox.max_value = max_val;
	spinbox.step = 1;
	spinbox.value = start_val;
	spinbox.value_changed.connect(func(_v): if state == State.IDLE: _show_duration());
	return spinbox; 
	
func _make_button(text: String, callback: Callable) -> Button:
	var button = Button.new();
	button.text = text;
	button.pressed.connect(callback);
	return button;
	
	
func _label(text:  String) -> Label:
	var createdLable = Label.new();
	createdLable.text = text;
	return createdLable;
