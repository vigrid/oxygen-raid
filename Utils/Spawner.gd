tool
extends Node2D


export(String, "Fuel", "Enemy") var SpawnerType


func _ready():
	set_process(true)


func _process(delta):
	update()


func _draw():
	if SpawnerType == "Fuel":
		draw_circle(Vector2(0, 0), 35, Color(0, 0, 1))
		draw_line(Vector2(-1000, -35), Vector2(1000, -35), Color(0, 0, 1))
		draw_line(Vector2(-1000, 35), Vector2(1000, 35), Color(0, 0, 1))
	elif SpawnerType == "Enemy":
		draw_circle(Vector2(0, 0), 35, Color(1, 0, 0))
		draw_line(Vector2(-1000, -35), Vector2(1000, -35), Color(1, 0, 0))
		draw_line(Vector2(-1000, 35), Vector2(1000, 35), Color(1, 0, 0))
	else:
		draw_circle(Vector2(0, 0), 35, Color(1, 1, 1))
		draw_line(Vector2(-1000, -35), Vector2(1000, -35), Color(1, 1, 1))
		draw_line(Vector2(-1000, 35), Vector2(1000, 35), Color(1, 1, 1))
