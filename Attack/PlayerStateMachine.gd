# 在 StateMachine 里加两个状态
class_name NormalState extends State
func enter():
	owner.hurtbox.can_be_interrupted = true

class_name DashState extends State
func enter():
	owner.hurtbox.can_be_interrupted = false   # 霸体
func exit():

	owner.hurtbox.can_be_interrupted = true
