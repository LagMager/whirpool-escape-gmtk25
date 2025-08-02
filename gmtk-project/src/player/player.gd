extends CharacterBody2D
#the player
@onready var player = $"."
@onready var anim = $AnimationPlayer
var ship_base = 25
var steering_angle = 15 
var speed = 300  # Reduced from 260

#needed for magnitude
var mass = 1
var angle = 0
var radius = 0
var centre_point = Vector2(240,135)
var orbit = 180
var steer_direction
var acceleration = Vector2.ZERO
var friciton = -55
var drag = -0.09

@export var player_health : Health

func _ready():
	player_health.died.connect(die)
	player_health.reset()


func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction(delta)
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()
	
	#print(velocity.angle_to(point)) 
	radius = player.position.distance_to(centre_point)
	#print(radius)
	#this creates a vector from the player to the centre point which is then normalised
	var directed_vector = centre_point - player.position
	var normalised_direction = directed_vector.normalized()
	
	#this allows for the contant motion - reduced from 5 to 3
	var forward_vector = transform.x
	velocity += forward_vector * 5
	#print(normalised_direction)
	
	#this is the centripetal force calcuations
	var magnitude = (mass * directed_vector.length() **2)/radius 
	#this protects from divide by 0 errors
	if radius == 0:
		magnitude = 0
	
	#print(magnitude)
	#this is is where the force is actually applied and where you can modify its strength 
	var circle_round_force = normalised_direction * magnitude * 6
	velocity += circle_round_force * delta
	#keeps 
	if directed_vector.length() > orbit:
		var new_forward_vector = forward_vector.slerp(directed_vector, 3 * delta)
		self.rotation = new_forward_vector.angle()
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
	if anim.is_playing():
		return
	player_health.take_damage(amount)
	anim.play("Blink")
	speed *= 0.4
	await anim.animation_finished
	speed = speed / 0.4

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
