extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var active = false
var is_quest_accepted = false
var is_quest_finished = false

var state = CHASE

onready var dialog
onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $HurtBox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()

		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()

		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
		
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * 10
	velocity = move_and_slide(velocity)
	
# warning-ignore:unused_argument
func unpause (timeline_end):
	get_tree().paused = false
	
func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 150
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.4)

func _on_Stats_no_health():
	if Quests.Quest4:
		Quests.princess_killed += 1
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	queue_free()


func _on_HurtBox_invincibility_started():
	animationPlayer.play("Start")


func _on_HurtBox_invincibility_ended():
	animationPlayer.play("Stop")


func _on_NPC_talk_body_entered(body):
	if body.name == "Player":
		active = true
		if not is_quest_accepted and not is_quest_finished:
			dialog = Dialogic.start("start_princess")
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect("dialogic_signal", self, "dialog_msg")
			dialog.connect("timeline_end", self, "unpause")
		if is_quest_accepted and is_quest_finished:
			if Quests.princess_killed == 1:
				Dialogic.set_variable("QuestRequirement", 1)
				dialog = Dialogic.start("finish_princess")
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect("dialogic_signal", self, "dialog_msg")
				dialog.connect("timeline_end", self, "unpause")
		if dialog != null and is_instance_valid(dialog):
			add_child(dialog)
			get_tree().paused = true
		
func dialog_msg(string):
	match string:
		"yes":
			is_quest_accepted = true
			is_quest_finished = false
			Quests.Quest4 = true
		"no":
			is_quest_accepted = false
			is_quest_finished = false
			Quests.Quest4 = false
		"yes_not_finished":
			is_quest_accepted = true
			is_quest_finished = false
		"no_not_finished":
			is_quest_accepted = true
			is_quest_finished = false
		"yes_finished":
			is_quest_accepted = true
			is_quest_finished = true
		"no_finished":
			is_quest_accepted = true
			is_quest_finished = false

func _on_NPC_talk_body_exited(body):
	if body.name == "Player":
		active = false

