extends Area2D


func _ready():
	connect("body_enter", self, "OnBodyEnter")
	connect("body_exit", self, "OnBodyExit")


func OnBodyEnter(body):
	if body.has_method("EnterFuel"):
		body.EnterFuel(self)


func OnBodyExit(body):
	if body.has_method("ExitFuel"):
		body.ExitFuel(self)
