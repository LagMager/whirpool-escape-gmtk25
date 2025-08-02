extends Node2D

@onready var label = $timer
@onready var timer = $timer/Timer
@onready var secs = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	secs += 1
	var m = int(secs / 60)
	var s = secs - m * 60
	label.text = '%02d:%02d' % [m, s]
