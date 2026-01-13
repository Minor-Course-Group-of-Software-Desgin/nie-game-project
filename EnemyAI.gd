extends CharacterBody2D

@onready var hurtbox := $Hurtbox
@onready var weapon := $MeleeWeapon

func _ready():
    hurtbox.hurt.connect(_on_hurt)
    # 简单 AI：每 1.2s 打一次
    var t := Timer.new()
    t.wait_time = 1.2
    t.timeout.connect(weapon.start_attack)
    add_child(t)
    t.start()

func _on_hurt(damage: int, _attacker: Node):
    # 扣血、闪白、硬直
    print("enemy hurt ", damage)

func interrupt():
    # 打断当前动画，切到硬直状态
    $AnimationPlayer.stop()
    $AnimationPlayer.play("hit_react")