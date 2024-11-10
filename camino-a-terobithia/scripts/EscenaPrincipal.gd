extends Node2D

@onready var timer_dia = $TimerDia
@onready var timer_ataques = $TimerAtaques
@onready var huevos = 3
@onready var Aguila = $Aguila
@onready var Zorrillo = $Zorrillo

func _ready() -> void:
	# Conecta la señal timeout de cada temporizador a fin_dia e iniciar_ataque
	timer_dia.timeout.connect(_fin_dia)
	timer_ataques.timeout.connect(_iniciar_ataque)
	timer_dia.start()
	timer_ataques.start()
	$TeroTierra.connect("terotierraclick", Callable(self, "_on_terotierraclick"))
	$TeroAereo.connect("teroaereoclick", Callable(self, "_on_teroaereoclick"))

# Método que se llama cuando el día se termina
func _fin_dia() -> void:
	timer_ataques.stop()  # Detenemos los ataques
	print("True")  # Puedes mostrar un mensaje de victoria si los huevos sobreviven

# Método que se llama cada vez que hay un ataque
func _iniciar_ataque() -> void:                                            
	# Alternar entre el Zorrillo y el Águila
	if randf() > 0.5:
		iniciar_ataque_zorrillo()
	else:
		iniciar_ataque_aguila()

# Función para iniciar el ataque del Zorrillo
func iniciar_ataque_zorrillo() -> void:
	$Zorrillo.animation_player.play("acecho")
	# Espera 15 segundos antes de pasar a la siguiente animación si no ha sido ahuyentado
	await get_tree().create_timer(15.0).timeout
	if $Zorrillo.animation_player.current_animation == "acecho":
		$Zorrillo.animation_player.play("robahuevo")
		reducir_huevos()

func _on_terotierraclick() -> void:
	print("El TeroTierra fue clickeado en la escena principal.")
	# Verifica el estado actual del Zorrillo y responde al clic en el TeroTierra
	if $Zorrillo.animation_player.current_animation == "acecho":
		$Zorrillo.animation_player.stop()
		$Zorrillo.animation_player.play("huida")
		print("El Zorrillo ha sido ahuyentado.")
		
func _on_teroaereoclick() -> void:
	print("El TeroAereo fue clickeado en la escena principal.")
	# Verifica el estado actual del Zorrillo y responde al clic en el TeroTierra
	if $Aguila.animation_player.current_animation == "acecho":
		$Aguila.animation_player.stop()
		$Aguila.animation_player.play("huida")
		print("El Aguila ha sido ahuyentada.")

# Función para iniciar el ataque del Águila
func iniciar_ataque_aguila() -> void:
	$Aguila.animation_player.play("acecho")
	# Espera 15 segundos antes de pasar a la siguiente animación si no ha sido ahuyentado
	await get_tree().create_timer(15.0).timeout
	if $Aguila.animation_player.current_animation == "acecho":
		$Aguila.animation_player.play("robahuevo")
		reducir_huevos()

# Método para reducir el contador de huevos y actualizar la escena
func reducir_huevos() -> void:
	if huevos > 0:
		huevos -= 1
		$Huevos.get_child(huevos).hide()
		if huevos <= 0:
			print("False")  # Termina el juego si no quedan huevos

# Método para finalizar el juego, puede mostrar un mensaje de victoria o derrota
func finalizar_juego(victoria: bool) -> void:
	if victoria:
		print("¡Victoria! Los huevos sobrevivieron el día.")
	else:
		print("¡Derrota! Todos los huevos fueron robados.")
	# Aquí puedes reiniciar el juego o volver al menú
