extends Control

@onready var animation_player = $AnimationPlayer
@onready var audio_player = $AudioStreamPlayer
@onready var fade_rect = $Overlay

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://ui/menu/menu_root.tscn")

func _change_scene() -> void:
	get_tree().change_scene_to_file("res://ui/menu/menu_root.tscn")


func _input(event: InputEvent) -> void:
	# 1. 检测鼠标左键点击事件
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		# 2. 只有当前正在播放 intro 动画（且不是淡出动画）时才执行跳过逻辑
		if animation_player.is_playing():
			# 创建补间动画对象
			var tween = create_tween()

			animation_player.stop()
			# 如果您有独立的 AudioStreamPlayer 节点播放音乐，需要在这里手动停止它，例如：
			audio_player.stop()
			
			tween.tween_property(fade_rect, "modulate:a", 0.0, 2.0)

			# 关闭鼠标输入 防止重新触发
			set_process_input(false)
			
			tween.finished.connect(_change_scene)
