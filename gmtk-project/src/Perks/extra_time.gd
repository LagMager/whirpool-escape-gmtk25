extends Perk


@export var time_bonus: float = 5.0
@export var time_data: TimeResource
var player_ui = null

func apply(ui):
	if time_data:
		time_data.add_time(time_bonus)
