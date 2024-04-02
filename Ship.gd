extends Sprite2D

var terran = null
var G = 1  # m^3 kg^-1 s^-2 (value in real world)
var velocity = Vector2.UP*10
var min_distance = INF

# Called when the node enters the scene tree for the first time.
func _ready():
	terran = $"../Terran"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var accel = acceleration($".", terran, 1.0, 1000000.0)
	velocity += accel * delta
	global_position += velocity * delta
	
func direction_to(from: Node2D, to: Node2D):
	# Calculate distance vector between the nodes
	return to.global_position - from.global_position

func acceleration(from: Node2D, to: Node2D, from_mass: float, to_mass: float) -> Vector2:
	# Calculate distance vector between the nodes
	var distance = direction_to(from, to)
	var distance_squared = distance.length_squared()
	
	# Calculate gravitational force magnitude
	var force_magnitude = (G * from_mass * to_mass) / distance_squared
	
	# Calculate gravitational force vector
	var force_vector = distance.normalized() * force_magnitude
	
	# Calculate acceleration using Newton's second law (F = ma)
	var acceleration = force_vector / from_mass
	
	if distance_squared < min_distance:
		min_distance = distance_squared
		print(distance_squared)
		print(acceleration)
		
	
	return acceleration
