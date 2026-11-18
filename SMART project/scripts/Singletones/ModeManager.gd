extends Node

enum modes {
	DEFAULT,
	TIMER,
	MUSIC,
	WANDER
}

var mode = modes.WANDER;
var prevNode = mode;
signal modeSwitch;

func getMode():
	return mode;

func switchMode(newMode):
	if(mode == newMode):
		return; #Do nothing if the mode doesn't change
	mode = newMode;
	modeSwitch.emit(mode);
