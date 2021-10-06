extends Node

var stateMachine : Node

export(NodePath) var label
export(NodePath) var sprite
export(float) var max_vel = 600.0
export(float) var accel = 150.0
export(float) var stop_force = 50.0
export(float) var gravity = 1200.0

var move : Vector2
var canDetectAir : bool = false

func _ready():
	stateMachine = get_parent()

func initialize(move_speed : float):
	move.x = move_speed
	if owner.is_on_floor():
		var coll : KinematicCollision2D = owner.get_slide_collision(owner.get_slide_count() - 1)
		if coll.get_normal() == Vector2.UP:
			var err = coll.get_collider().get("fall_speed")
			if err:
				move.y = coll.get_collider().fall_speed

func set_active(value : bool):
	set_physics_process(value)
#	set_process(value)
	if !value:
		move = Vector2.ZERO
		canDetectAir = false

func teclas():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var up = Input.is_action_pressed("ui_up")
	
	if up:
#		if owner.is_on_floor():
			stateMachine.changeState("air",[move,true])
			return
	
	if right:
		move.x += accel
		get_node(sprite).flip_h = true
	elif left:
		move.x -= accel
		get_node(sprite).flip_h = false
	else:
		move.x = move_toward(move.x,0.0,stop_force)
	
	move.x = clamp(move.x,-max_vel,max_vel)

func _physics_process(delta):
	teclas()
	if !owner.is_on_floor():
		move.y += gravity * delta
	else:
		if move.y > 0:
			move.y = 0

#	if owner.is_on_floor():
#		var coll : KinematicCollision2D = owner.get_slide_collision(owner.get_slide_count() - 1)
#		if coll.get_normal() == Vector2.UP:
#			move.y = coll.get_collider().fall_speed
	
#	get_node(label).set_text("ground")
	owner.move_and_slide_with_snap(move, Vector2(0,40), Vector2.UP)
