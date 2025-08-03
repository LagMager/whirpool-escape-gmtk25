extends Control

@export var player_health : Health

@onready var health_bar = $HealthBar  # adjust to your node path
@onready var health_label = $HealthBarLabel
func _ready():
	if player_health:
		update_ui(player_health.current_health, player_health.get_max_health())
		player_health.health_changed.connect(update_ui)

func update_ui(current_health, max_health):
	print("Updating UI with:", current_health, "/", max_health)
	health_label.text = str(current_health) + ' / ' + str(max_health)
	health_bar.max_value = max_health
	health_bar.value = current_health
	
func show_death_flash():
	print("Player died!")  # or show UI animation
	
