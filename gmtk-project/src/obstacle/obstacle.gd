extends Area2D
class_name  Obstacle


@export var speed = 100.0
@export var damage = 1 
@export var sprite_texture: Texture
@export var destroy_on_hit = true
func _ready():
	if sprite_texture:
		$Sprite2D.texture = sprite_texture
		


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage)
		if destroy_on_hit:
			queue_free()
