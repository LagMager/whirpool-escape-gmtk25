extends VBoxContainer


@export var time_data : TimeResource

# Called when the node enters the scene tree for the first time.
func _ready():
	if time_data:
		time_data.time_changed.connect(update_ui)
		update_ui(time_data.time_left, time_data.total_time)

func _process(delta):
	if time_data:
		time_data.tick(delta)

func update_ui(current_time, total_time):
	$TimeBar.max_value = total_time
	$TimeBar.value = current_time
	$TimeLabel.text = "TIME: " + str(int(current_time))
