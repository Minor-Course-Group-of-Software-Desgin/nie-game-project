extends CharacterBody2D


@export var SPEED = 400.0
@export var JUMP_VELOCITY = -500.0
@export var SPRINT_VELOCITY = 2000.0

@export var MAX_STAMINA = 2.0
@export var STAMINA_RECOVERY_RATE = 0.5
var stamina = MAX_STAMINA

var direction : Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	# 从玩家的输入中获取角色移动方向
	direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("point_up","point_down")
	)
	# 恢复体力
	stamina = move_toward(stamina, MAX_STAMINA, STAMINA_RECOVERY_RATE * delta)
	# 移动角色
	if $SprintControlTimer.is_stopped():
		# 如果角色不处于冲刺状态
		velocity.x = direction.x * SPEED
		velocity.y += 0.0 if is_on_floor() else get_gravity().y * delta
	else: # 冲刺
		velocity = direction * SPRINT_VELOCITY
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("sprint") and $SprintControlTimer.is_stopped() and stamina >= 1:
		stamina -= 1	
		$SprintControlTimer.start()
	elif event.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


func _on_sprint_control_timer_timeout() -> void:
	# 冲刺结束将速度置零防止滑行
	velocity = Vector2.ZERO
