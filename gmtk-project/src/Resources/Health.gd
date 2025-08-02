extends Resource
class_name Health
@export var max_health: int = 4
@export var bonus_health: int = 0
var current_health: int = 4


signal health_changed(current: int, max: int)
signal died

func get_max_health() -> int:
	return max_health + bonus_health

func take_damage(amount: int = 1):
	current_health = max(current_health - amount, 0)
	emit_signal("health_changed", current_health, get_max_health())
	if current_health == 0:
		emit_signal("died")

func heal(amount: int = 1):
	current_health = min(current_health + amount, get_max_health())
	emit_signal("health_changed", current_health, get_max_health())

func add_bonus_health(amount: int):
	bonus_health += amount
	current_health = min(current_health, get_max_health())
	emit_signal("health_changed", current_health, get_max_health())

func reset():
	current_health = get_max_health()
	emit_signal("health_changed", current_health, get_max_health())
