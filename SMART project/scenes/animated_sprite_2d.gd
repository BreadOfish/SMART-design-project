extends AnimatedSprite2D

const TEST_DIALOGUE:  Array[String]  = [
	"Hello world!",
	"This is a test dialog box!",
	"Lorum Ipsum"
	];

func _ready():
	DialogueManager.start_dialog(global_position, TEST_DIALOGUE);
