extends Node2D

var player: AudioStreamPlayer;
var slider: HSlider;
var audioPos;

func _ready() -> void:
	DisplayServer.window_set_size(Vector2i(1000, 1000))

	player = AudioStreamPlayer.new();
	player.stream = load("res://music/Vibing Over Venus.mp3");
	add_child(player);
	
	var box = HBoxContainer.new();
	box.position = Vector2(-100, 200);
	add_child(box);
	
	box.add_child(_make_button("Play", _on_play));
	box.add_child(_make_button("Pause", _on_pause));
	
	slider = HSlider.new();
	slider.custom_minimum_size = Vector2(120, 0);
	slider.min_value = 0.0;
	slider.max_value = 1.0;
	slider.step = 0.01;
	slider.value = 0.5;
	slider.value_changed.connect(_on_volume_change);
	box.add_child(slider);
	
	var playing = Label.new();
	playing.text = "Now playing: Vibing Over Venus!\nBy Kevin MacLeod";
	box.add_child(playing);
	
	_on_volume_change(slider.value);

func _on_play() -> void:
	if player.stream_paused:
		player.stream_paused = false;
	elif !player.playing:
		player.play();

func _on_pause() -> void:
	if player.playing:
		player.stream_paused = true;
	
func _on_volume_change(value: float) -> void:
	player.volume_db = linear_to_db(value);
	
func _make_button(text: String, callback: Callable) -> Button:
	var button = Button.new();
	button.text = text;
	button.pressed.connect(callback);
	return button;
