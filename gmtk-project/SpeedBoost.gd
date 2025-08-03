extends Perk

@export var speed_multiplier: float = 1.3 

func apply(player):
	player.speed *= speed_multiplier
