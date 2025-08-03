extends Node

var player: Player = null
var ui: Node = null
func set_targets(p: Node, u: Node):
	player = p
	ui = u
	
	for perk in get_children():
		if perk.has_method("apply"):
			perk.apply(player) 


func add_perk(perk_scene: PackedScene):
	var perk = perk_scene.instantiate()
	add_child(perk)

	if perk.has_method("apply"):
		
		if perk.apply_to_ui:
			perk.apply(ui)
			print("This is getting applied to UI")
		else:
			perk.apply(player)
