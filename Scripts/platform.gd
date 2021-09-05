extends KinematicBody2D

var fall_speed : float = 60.0

func _ready():
	pass

func setFallSpeed(speed : float):
	fall_speed = speed

func _physics_process(delta):
	position.y += fall_speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
