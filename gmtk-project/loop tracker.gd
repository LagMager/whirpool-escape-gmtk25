extends Node2D

var north = false
var east = false
var west = false
var south = false
var looped = false
var loop_num = 0
signal loop_tick(loop_num)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if north == true and east == true and west == true and south == true:
		print("loop!")
		looped = true
		loop_update()
		north = false
		east = false
		west = false
		south = false
		
		


func _on_north_body_entered(body: Node2D) -> void:
	north = true
	

func _on_east_body_entered(body: Node2D) -> void:
	east = true


func _on_west_body_entered(body: Node2D) -> void:
	west = true


func _on_south_body_entered(body: Node2D) -> void:
	south = true


func loop_update():
	if looped == true:
		loop_num += 1 
		print(loop_num)
		loop_tick.emit(loop_num)
		
		
