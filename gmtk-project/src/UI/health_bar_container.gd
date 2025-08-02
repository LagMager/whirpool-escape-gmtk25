extends CenterContainer

@export var player_health : Health

@onready var health_bar = $HealthBar  # adjust to your node path

func _ready():
	if player_health:
		player_health.health_changed.connect(update_ui)
		update_ui(player_health.current_health, player_health.get_max_health())

func update_ui(current_health: int, max_health: int):
	print("Updating UI with:", current_health, "/", max_health)
	health_bar.max_value = max_health
	health_bar.value = current_health

func show_death_flash():
	print("Player died!")  # or show UI animation
