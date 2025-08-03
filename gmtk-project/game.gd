extends Node2D

var test_perk = preload("res://src/Perks/better_health_perk.tscn")
var test_perk2 = preload("res://src/Perks/extra_time.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$PerkManager.set_targets($Player, $UI/TopBar/VBoxContainer/TimerContainer)
	$PerkManager.add_perk(test_perk)
	$PerkManager.add_perk(test_perk2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
