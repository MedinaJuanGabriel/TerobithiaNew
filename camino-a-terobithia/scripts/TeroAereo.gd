extends CharacterBody2D  # tero aéreo

signal teroaereoclick

@onready var area2d = $Area2D
@onready var animation_player = $AnimationPlayer

# Función _ready que conecta el evento de entrada
func _ready() -> void:
	area2d.input_event.connect(_dentro_area)

# Función que se ejecuta al hacer clic en el área del tero aéreo
func _dentro_area(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		emit_signal("teroaereoclick")
		print("Tero aéreo clickeado, ataque aéreo")
		realizar_ataque()

# Función de ataque del tero aéreo
func realizar_ataque() -> void:
	animation_player.play("vuelo_ataque_aereo")
