extends CharacterBody2D
class_name enemy_movement

var speed = 100

enum enemy_states {MOVERIGHT, MOVELEFT, MOVEUP, MOVEDOWN}
var current_states
var dir

func _physics_process(_delta):
	match current_states:
		enemy_states.MOVERIGHT:
			move_right()
		enemy_states.MOVELEFT:
			move_left()
		enemy_states.MOVEUP:
			move_up()
		enemy_states.MOVEDOWN:
			move_down()
	move_and_slide()

#generates a random num from 0-3 for random_direction
func random_generation():
	dir = randi() % 4
	random_direction()

func random_direction():
	match dir:
		0:
			current_states = enemy_states.MOVERIGHT
		1:
			current_states = enemy_states.MOVELEFT
		2:
			current_states = enemy_states.MOVEUP
		3:
			current_states = enemy_states.MOVEDOWN

func move_right():
	velocity = Vector2.RIGHT * speed

func move_left():
	velocity = Vector2.LEFT * speed

func move_up():
	velocity = Vector2.UP * speed

func move_down():
	velocity = Vector2.DOWN * speed

func _on_timer_timeout() -> void:
	pass # Replace with function body.
