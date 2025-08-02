extends Label

var loop = 0
var do_loop = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if do_loop == true:
		loop += 1
		$".".text = str("loops: ",loop)
		do_loop = false






func _on_node_2d_loop_tick(loop_num: Variant) -> void:
	do_loop = true
