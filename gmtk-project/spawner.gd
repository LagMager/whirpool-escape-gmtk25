extends Node2D

var rand_x = 0
var rand_y = 0
var pos = 0
@onready var timer = $Timer

var object = preload("res://src/obstacle/Obstacle.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func spawn(pos):
	rand_x = randi_range(0,1)
	rand_y = randi_range(0,370)
	pos = Vector2(rand_x,rand_y)
	
	var instance = object.instantiate()
	instance.position = pos
	add_child(instance)
	
	


func _on_timer_timeout() -> void:
	timer.wait_time = randi_range(1,40)
	print("doh")
	spawn(pos)
