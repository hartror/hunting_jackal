extends Line2D

var ship = null

# Called when the node enters the scene tree for the first time.
func _ready():
	ship = $"../ShipSprite"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	add_point(ship.global_position)
	if get_point_count() > 1000:
		remove_point(0)
