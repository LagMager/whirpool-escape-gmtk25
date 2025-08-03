extends Resource
class_name TimeResource

signal time_changed(current: float, total: float)
signal time_ran_out
signal time_added(amount: float)

@export var total_time: float = 20.0
@export var time_left: float = 20.0

func tick(delta: float):
	if time_left <= 0:
		return

	time_left = max(time_left - delta, 0)
	emit_signal("time_changed", time_left, total_time)

	if time_left == 0:
		emit_signal("time_ran_out")

func add_time(amount: float):
	#print('adding time:' + str(amount))
	time_left += amount
	#print(time_left)
	emit_signal("time_added", amount)
	emit_signal("time_changed", time_left, total_time)

func set_total_time(new_total: float):
	total_time = new_total
	time_left = min(time_left, total_time)
	emit_signal("time_changed", time_left, total_time)
