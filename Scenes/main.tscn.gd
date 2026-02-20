extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Detective.in_doorway:
		$"CanvasLayer/EnterPrompt".visible = true
		$CanvasLayer/EnterPrompt/ColorRect/AnimatedSprite2D.play()
	else:
		$"CanvasLayer/EnterPrompt".visible = false
