extends Node

var stateMachine : Node

export(NodePath) var label
export(NodePath) var sprite
export(float) var max_vel = 800.0
export(float) var accel = 250.0
export(float) var jump_vel = 800.0
export(float) var gravity = 1200.0

var canDetectFloor : bool = false

var move : Vector2

func _ready():
	stateMachine = get_parent()
	set_physics_process(false)

func set_active(value : bool):
	set_physics_process(value)
	set_process(value)
	if !value:
		move = Vector2.ZERO
		canDetectFloor = false

func detectGround():
	if owner.is_on_floor():
		stateMachine.changeState("ground",[move.x])

func initialize(move_vel : Vector2, jumping: bool):
	if jumping:
		move.y = -jump_vel
	else:
		move.y = move_vel.y
	move.x = move_vel.x
	yield(get_tree().create_timer(0.08),"timeout")
	canDetectFloor = true

func teclas():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var up = Input.is_action_pressed("ui_up")
	
	if up and owner.isOnFloor:
		move.y = -jump_vel
	
	if right:
		move.x += accel
		get_node(sprite).flip_h = true
	elif left:
		move.x -= accel
		get_node(sprite).flip_h = false
	
	move.x = clamp(move.x,-max_vel,max_vel)

func detectWall():
	if owner.is_on_wall():
		for i in owner.get_slide_count():
			var coll = owner.get_slide_collision(i)
			if coll.get_normal() != Vector2.UP:
				stateMachine.changeState("bounce", [move,coll.get_normal()])

func _physics_process(delta):
	teclas()
	move.y += gravity * delta
	detectWall()
	if canDetectFloor:
		detectGround()
#	get_node(label).set_text("air")
	owner.move_and_slide(move,Vector2.UP)
