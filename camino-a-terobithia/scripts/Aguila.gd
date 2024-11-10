extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
var en_acecho = false

func aparecer() -> void:
	en_acecho = true
	animation_player.play("acecho")
	await get_tree().create_timer(15).timeout
	if en_acecho:
		robar_huevo()

func robar_huevo() -> void:
	en_acecho = false
	animation_player.play("robahuevo")
	await animation_player.animation_finished("robahuevo")
	get_tree().root.get_node("EscenaPrincipal").reducir_huevos()
