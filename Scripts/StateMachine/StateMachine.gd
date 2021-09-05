extends Node

onready var ground = $Ground
onready var air = $Air
onready var bounce = $Bounce

onready var statesDict = {
	"ground": ground,
	"air": air,
	"bounce": bounce
}

var currentState : Node

func _ready():
	currentState = ground

func changeState(new_state, args : Array = []):
#	print("se comprobara el estado: " + new_state)
	
	var _new_state = statesDict[new_state]
	
	if _new_state == currentState:
		return
	
	currentState.set_active(false)
	_new_state.callv("initialize",args)
	_new_state.set_active(true)
	currentState = _new_state
	
#	print(new_state)
