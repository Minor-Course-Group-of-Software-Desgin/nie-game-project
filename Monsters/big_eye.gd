extends CharacterBody2D

@onready var vision_area_2d: Area2D = $VisionArea2D
@onready var hit_area_2d_2: Area2D = $HitArea2D2
@onready var ray_cast: RayCast2D = $RayCast2D

var direction = 1
@export var speed = 50

signal monster_hit

func _process(delta: float) -> void:
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider is StaticBody2D:
			change_direction()
	
	velocity.x = speed * delta * direction
	position.x += velocity.x
	move_and_slide()

func change_direction():
	direction *= -1
	position.x += direction * 2
	scale.x *= -1

func _on_vision_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		speed *= 3

func _on_vision_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		await get_tree().create_timer(0.2).timeout
		speed /= 3

func _on_hit_area_2d_2_body_entered(body: Node2D) -> void:
	set_process(false)
	monster_hit.emit()
