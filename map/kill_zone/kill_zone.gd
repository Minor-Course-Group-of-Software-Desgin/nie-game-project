extends Area2D

signal hitted;

func _on_body_entered(body: Node2D) -> void:
	hitted.emit()
