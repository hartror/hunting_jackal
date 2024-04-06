extends RichTextLabel

@onready var ship_sprite = $"../Ship/ShipSprite"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "%.2f m/s" % ship_sprite.velocity.length()
