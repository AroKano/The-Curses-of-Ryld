extends Camera2D

onready var topLeft = $Limits/TopLeft
onready var bottomRiight = $Limits/BottomRight

func _ready():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_bottom = bottomRiight.position.y
	limit_right = bottomRiight.position.x
