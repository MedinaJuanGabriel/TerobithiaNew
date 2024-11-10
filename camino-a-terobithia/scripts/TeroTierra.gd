extends CharacterBody2D  # tero tierra

signal terotierraclick

@onready var area2d = $Area2D
@onready var animation_player = $AnimationPlayer

# Función _ready que conecta el evento de entrada
func _ready() -> void:
	area2d.input_event.connect(_dentro_area)

# Función que se ejecuta al hacer clic en el área del tero terrestre
func _dentro_area(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		emit_signal("terotierraclick")
		print("Tero terrestre clickeado, realizando acción de ataque")
		realizar_ataque()

# Función de ataque del tero terrestre
func realizar_ataque() -> void:
	animation_player.play("ataque_terrestre")
	
