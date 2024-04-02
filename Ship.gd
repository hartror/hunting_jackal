extends Sprite2D

var terran = null
var G = 1  # m^3 kg^-1 s^-2 (value in real world)
var velocity = Vector2.UP*15
var min_distance = INF

# Called when the node enters the scene tree for the first time.
func _ready():
	terran = $"../Terran"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var k1_p = velocity * delta
	var k1_v = acceleration($".".global_position, terran.global_position, 1.0, 1000000.0) * delta
	var k2_p = (velocity + k1_v * 0.5) * delta
	var k2_v = acceleration($".".global_position + k1_p * 0.5, terran.global_position, 1.0, 1000000.0) * delta
	var k3_p = (velocity + k2_v * 0.5) * delta
	var k3_v = acceleration($".".global_position + k2_p * 0.5, terran.global_position, 1.0, 1000000.0) * delta
	var k4_p = (velocity + k3_v) * delta
	var k4_v = acceleration($".".global_position + k3_p, terran.global_position, 1.0, 1000000.0) * delta
	velocity += (k1_v + k2_v*2 + k3_v*2 + k4_v) / 6
	global_position += (k1_p + 2*k2_p + 2*k3_p + k4_p) / 6

	
func direction_to(from: Vector2, to: Vector2):
	# Calculate distance vector between the nodes
	return to - from


func acceleration(from: Vector2, to: Vector2, from_mass: float, to_mass: float) -> Vector2:
	# Calculate distance vector between the nodes
	var distance = direction_to(from, to)
	var distance_squared = distance.length_squared()
	# Calculate gravitational force magnitude
	var force_magnitude = (G * from_mass * to_mass) / distance_squared
	
	# Calculate gravitational force vector
	var force_vector = distance.normalized() * force_magnitude
	
	# Calculate acceleration using Newton's second law (F = ma)
	var acceleration = force_vector / from_mass
	
	return acceleration
