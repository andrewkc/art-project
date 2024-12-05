extends Area3D

var is_player_near: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("ready 1")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("ready 2")
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	print("entered")
	if body.name == "CharacterBodyCamera": # Cambia "CameraBody" al nombre de tu nodo padre de la cámara
		is_player_near = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	print("exited")
	if body.name == "CharacterBodyCamera":
		is_player_near = false
