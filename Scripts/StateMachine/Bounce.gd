extends Node

var stateMachine : Node

export(NodePath) var bounce_timer_node
export(float) var gravity = 1200.0
export(float) var bounce_damp = 0.9
export(float) var bounce_time = 0.4

var canStopBounce : bool = false
var canDetectInput : bool = false

var move : Vector2

func _ready():
	stateMachine = get_parent()
	set_physics_process(false)

func initialize(dir : Vector2, normal : Vector2):
	move = dir.bounce(normal) * bounce_damp
	get_node(bounce_timer_node).start(bounce_time)

func set_active(value : bool):
	set_physics_process(value)
	set_process(value)
	if !value:
		move = Vector2.ZERO
		canStopBounce = false
		canDetectInput = false
		get_node(bounce_timer_node).stop()

func teclas():
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		if owner.is_on_floor():
			stateMachine.changeState("ground",[move.x])
		else:
			stateMachine.changeState("air",[move,false])

func detectGround():
	if owner.is_on_floor():
		stateMachine.changeState("ground",[move.x])
		return

func _physics_process(delta):
	move.y += gravity * delta
	owner.move_and_slide(move,Vector2.UP)
	detectGround()
	if canDetectInput:
		teclas()

func _on_bounceOff_timeout():
	canDetectInput = true
