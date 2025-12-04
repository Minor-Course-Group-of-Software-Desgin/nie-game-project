extends Node2D

@export var player_spawn_position:Vector2
@export var next_Scene:String 
var can_teleport = false
func _ready() -> void:
	set_process(false)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		can_teleport = true
		set_process(true)
		
func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		can_teleport = false
		set_process(false)

func _process(_delta: float) -> void:
	if can_teleport == false:
		return
	if Input.is_action_just_pressed("teleport"):
		get_tree().change_scene_to_file.call_deferred(next_Scene)
