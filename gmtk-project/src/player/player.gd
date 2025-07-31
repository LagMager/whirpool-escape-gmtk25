extends CharacterBody2D

var ship_base = 24
var steering_angle = 15 
var speed = 260


var steer_direction
var acceleration = Vector2.ZERO
var friciton = -55
var drag = -0.09

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction(delta)
	calculate_steering(delta)
	velocity += acceleration * delta
	print(velocity)
	move_and_slide()

## Gets the input from the player's controller.
func get_input():
	var turn = Input.get_axis("steer_left","steer_right")
	steer_direction = turn * deg_to_rad(steering_angle)
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * speed


## Calculates the direction of steering.
func calculate_steering(delta):
	var ship_rear = position - transform.x * ship_base / 2.0
	var ship_front = position + transform.x * ship_base / 2
	ship_rear += velocity * delta
	ship_front += velocity.rotated(steer_direction) * delta
	var new_direction : Vector2 = ship_rear.direction_to(ship_front)
	velocity = new_direction * velocity.length()
	rotation = new_direction.angle()


## Applies a force of friction to the player when not accelerating
func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force = velocity * friciton * delta
	var drag_force = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force
