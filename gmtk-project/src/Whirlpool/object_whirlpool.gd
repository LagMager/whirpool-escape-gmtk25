extends Node2D

@export var pull_strength := 50.0
@export var spin_strength := -50.0


func _process(delta):
	rotation += 1.0 * delta
	for body in get_overlapping_bodies():
		if body is Node2D:
			apply_pull(body, delta)

func get_overlapping_bodies() -> Array:
	var area = $Area2D
	return area.get_overlapping_bodies()

func apply_pull(target: Node2D, delta: float):
	var dir = (global_position - target.global_position).normalized()
	var perpendicular = Vector2(-dir.y, dir.x)  # 90° rotated vector for spin

	# Spiral inward velocity
	var force = (dir * pull_strength) + (perpendicular * spin_strength)
	target.global_position += force * delta
