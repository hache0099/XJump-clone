extends Node2D

const platforms = [
	preload("res://Scenes/platform_large.tscn"),
	preload("res://Scenes/platform_small.tscn")]

const distances = {
	0: [170.0,595.0],
	1: [114.0,651.0]
}

func _ready():
	randomize()
#	Engine.set_time_scale(0.2)

func create_platform(type : int):
	var p = platforms[type].instance()
	var rand_pos = rand_range(distances[type][0],distances[type][1])
	p.position = Vector2(rand_pos,-10)
	add_child(p)

#func _physics_process(delta):
#	if $player.position.y <= 100:
#		get_tree().call_group("platform","pass")

func _on_platform_spawn_timeout():
	create_platform(randi() % 2)
