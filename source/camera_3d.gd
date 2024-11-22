extends Camera3D

# Velocidad de movimiento
var move_speed = 5.0
var look_speed = 0.1

func _process(delta):
	# Movimiento
	var direction = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("move_up"):
		direction += transform.basis.y
	if Input.is_action_pressed("move_down"):
		direction -= transform.basis.y
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		translate(direction * move_speed * delta)

func _input(event):
	# Girar cámara solo en el eje Y (izquierda/derecha) mientras el botón derecho está presionado
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		# Solo rotar en el eje Y (izquierda/derecha)
		rotate_y(deg_to_rad(-event.relative.x * look_speed))
