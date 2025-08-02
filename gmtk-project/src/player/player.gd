extends CharacterBody2D

@onready var player = $"."

var ship_base = 25
var steering_angle = 15 
var speed = 100
var rospeed = 2
var mass = 0.5
var angle = 0
var radius = 0
var point = Vector2(245,108)
var steer_direction
var acceleration = Vector2.ZERO
var friciton = -55
var drag = -0.09

var max_health: int = 4
var current_health : int

func _ready():
	current_health = max_health


func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction(delta)
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()
	#circular_motion()
	#print(velocity.angle_to(point)) 
	radius = player.position.distance_to(point)
	#print(radius)
	var directed_vector = point - player.position
	var normalised_direction = directed_vector.normalized()
	var forward_vector = transform.x
	velocity += forward_vector *  25 
	#print(normalised_direction)
	var magnitude = (mass * directed_vector.length() **2)/radius 
	if radius == 0:
		magnitude = 0
	
	print(magnitude)
	var circle_round_force = normalised_direction * magnitude *3
	velocity += circle_round_force * delta

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


func take_damage(amount: int = 1) -> void:
	current_health -= amount
	if current_health <= 0:
		die()

func die() -> void:
	#Add trigger later
	print("im dead")

#func circular_motion():
	#radius = player.position.distance_to(point)
	##print(radius)
	#var directed_vector = point - player.position
	#var normalised_direction = directed_vector.normalized()
	##print(normalised_direction)
	#var magnitude = (mass * directed_vector.length() **2)/radius 
	#print(magnitude)
