extends Sprite2D

var speed = 400
var angular_speed = PI
var angle = 0
var distance = 0
var terran = null
var G = 6.674*pow(10, -11)

# Called when the node enters the scene tree for the first time.
func _ready():
	terran = $"../Terran"
	# Calculate the vector from node A to node B
	var direction = global_position - terran.global_position
	
	# Calculate the angle between the vector and the x-axis
	angle = direction.angle()
	distance = direction.length()

	# Print the angle in degrees
	print("Period: ", to_period(1.08, 1000000.0)/60/60)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle += angular_speed * delta
	global_position = polar_to_cart(angle, distance) + terran.global_position
	
	
func polar_to_cart(angle: float, radius: float) -> Vector2:
	# Create a Vector2 with the calculated x and y components
	return Vector2(radius * cos(angle), radius * sin(angle))

func to_period(distance: float, mass: float):
	return 2*PI*sqrt(pow(distance, 3)/(mass*G))
