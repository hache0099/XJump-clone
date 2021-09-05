extends KinematicBody2D

onready var curve = load("res://accel.tres")

const GRAVITY : float = 1200.0
const ACCEL : float = 100.0

var max_speed : float = 700.0
var iter_speed : float = 0.05 # Multiply by delta pls
var iterar : float = 0.0 

var bouncing : bool = false
var jumping = true

var isOnFloor : bool = false

var dir : int = 0

var move = Vector2()

func _ready():
	$Label.set_as_toplevel(true)

#func teclas(_delta):
#	var right = Input.is_action_pressed("ui_right")
#	var left = Input.is_action_pressed("ui_left")
#	var up = Input.is_action_pressed("ui_up")
#
#	dir = int(right) - int(left)
	
#	if left or right:
#		iterar += iter_speed
#		dir = int(right) - int(left)
#	else:
#		iterar = move_toward(iterar,0,iter_speed)
	
#	if right:
#		move.x += ACCEL
#		$Sprite.flip_h = true
#	elif left:
#		move.x -= ACCEL
#		$Sprite.flip_h = false
#	else:
#		if !bouncing:
#			move.x = move_toward(move.x,0.0,30.0)
#
#	move.x = clamp(move.x,-max_speed,max_speed)
#
#	if up and is_on_floor():
#		jumping = true
#		move.y -= 700.0
	
#	iterar = clamp(iterar,0.0,1.0)
#
#	move.x = max_speed * curve.interpolate(iterar) * dir

func detectFloorFunc():
	var coll = $detectFloor.get_overlapping_bodies()
	isOnFloor = !coll.empty()

func _physics_process(delta):
	detectFloorFunc()
	
	var state = $StateMachine.currentState.get_name()
	var st_move = $StateMachine.currentState.move
	$Label.set_text(state + ": " + str(st_move))

#func detectWall():
#	if is_on_wall():
#		for i in get_slide_count():
#			var coll = get_slide_collision(i)
#			if coll.get_normal() != Vector2.UP:
#				move = move.bounce(coll.get_normal())
#				print(move)
#				bouncing = true
#				$bounceOff.start()

func _on_detectFloor(body, extra_arg_0):
#	isOnFloor = extra_arg_0
	pass
