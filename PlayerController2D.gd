class_name PlayerController2D
extends KinematicBody2D

"""
PlayerController2D
This class extends a KinematicBody2D for creating a controllable
2D player. It maps some default "ui" inputs from Godot to apply
physics on the KinematicBody2D.

This is the current input map:
    * ui_left for moving left
    * ui_right for moving right
    * ui_accept for jumping
"""

var motion : Vector2

export(int) var speed := 50
export(int) var move_mod := 4
export(int) var jump_mod := 4
export(int) var gravity := 10
export(float) var friction := 0.5


func _inputs() -> void:
    if Input.is_action_pressed("ui_left"):
        motion.x = -speed * move_mod

    if Input.is_action_pressed("ui_right"):
        motion.x = speed * move_mod

    if Input.is_action_just_pressed("ui_accept"):
        if is_on_floor():
            motion.y = -speed * jump_mod


func _motion() -> void:
    motion = move_and_slide(motion, Vector2.UP)


func _friction() -> void:
    motion.x = lerp(motion.x, 0, friction)


func _gravity() -> void:
    motion.y += gravity

    if is_on_floor():
        motion.y = min(motion.y, 5)

    motion.y = min(motion.y, speed * jump_mod)

func _physics_process(delta: float) -> void:
    _inputs()
    _motion()
    _friction()
    _gravity()
