extends Area2D
class_name Hitbox

@export var damage: int = 10
@export var hit_once_per_attack := true   # 同一次攻击是否只能打中同一目标一次

var _already_hit: Array[Node] = []

func enable():
	set_deferred("monitoring", true)
	_already_hit.clear()

func disable():
	set_deferred("monitoring", false)

# 由 MeleeWeapon 在动画帧中调用
func _on_Hitbox_body_entered(body: Node2D):
	if hit_once_per_attack and body in _already_hit: return
	_already_hit.append(body)

	var hurtbox := body as Hurtbox
	if hurtbox:

		hurtbox.receive_damage(damage, get_parent().owner)   # owner=玩家或敌人
