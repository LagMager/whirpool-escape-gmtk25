extends Perk

@export var health_bonus: int = 2
@export var PlayerHealth: Health

func apply(player):
	if applied:
		return
	print("i'm applied lol")
	PlayerHealth.add_bonus_health(health_bonus)
	applied = true
