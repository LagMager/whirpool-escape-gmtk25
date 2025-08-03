extends Node
class_name Perk

@export var perk_name: String
@export var description: String
@export var icon: Texture
@export var perk_type: String
@export var modifiers := {}
@export var apply_to_ui : bool = false
var applied : bool = false

func get_modifiers():
	return modifiers

func apply(objective):
	pass
