extends Area2D
class_name Hurtbox

signal hurt(damage: int, attacker: Node)

@export var can_be_interrupted := true   # 玩家冲刺时可把该勾去掉
@export var invincible := false

func receive_damage(damage: int, attacker: Node):
    if invincible: return
    hurt.emit(damage, attacker)
    # 打断逻辑：直接通知状态机
    if can_be_interrupted and owner.has_method("interrupt"):
        owner.interrupt()