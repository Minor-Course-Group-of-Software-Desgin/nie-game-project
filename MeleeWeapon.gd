extends Node2D
class_name MeleeWeapon

@export var cooldown: float = 0.5
@onready var timer: Timer = $Timer
@onready var hitbox: Hitbox = $Hitbox

func _ready():
    timer.wait_time = cooldown
    hitbox.monitoring = false

# 由动画帧或输入触发
func start_attack():
    if timer.is_stopped():
        timer.start()
        hitbox.enable()
        # 动画播放、特效等
        # ...

# 动画结束帧调用
func end_attack():
    hitbox.disable()