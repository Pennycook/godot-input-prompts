# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
class_name JoypadMotionTextures
extends Resource
## Textures used by a [JoypadMotionPrompt] or [ActionPrompt].
##
## Textures used by a [JoypadMotionPrompt] or [ActionPrompt]. Stores a texture
## for each joypad axis and value.

## Texture for Axis 0 - (Left Stick Left, Joystick 0 Left)
@export var axis_0_minus: Texture2D = null

## Texture for Axis 0 + (Left Stick Right, Joystick 0 Right)
@export var axis_0_plus: Texture2D = null

## Texture for Axis 1 - (Left Stick Up, Joystick 0 Up)
@export var axis_1_minus: Texture2D = null

## Texture for Axis 1 + (Left Stick Down, Joystick 0 Down)
@export var axis_1_plus: Texture2D = null

## Texture for Axis 2 - (Right Stick Left, Joystick 1 Left)
@export var axis_2_minus: Texture2D = null

## Texture for Axis 2 + (Right Stick Right, Joystick 1 Right)
@export var axis_2_plus: Texture2D = null

## Texture for Axis 3 - (Right Stick Up, Joystick 1 Up)
@export var axis_3_minus: Texture2D = null

## Texture for Axis 3 + (Left Stick Down, Joystick 1 Down)
@export var axis_3_plus: Texture2D = null

## Texture for Axis 4 - (Joystick 2 Left)
@export var axis_4_minus: Texture2D = null

## Texture for Axis 4 + (Left Trigger, Sony L2, Xbox LT, Joystick 2 Right)
@export var axis_4_plus: Texture2D = null

## Texture for Axis 5 - (Joystick 2 Up)
@export var axis_5_minus: Texture2D = null

## Texture for Axis 5 + (Right Trigger, Sony R2, Xbox RT, Joystick 2 Down)
@export var axis_5_plus: Texture2D = null


## Return the [Texture2D] associated with the specified [InputEvent], or null.
func get_texture(event: InputEvent) -> Texture2D:
	if not event is InputEventJoypadMotion:
		return null
	var motion_event := event as InputEventJoypadMotion
	var axis = motion_event.axis
	var axis_value = motion_event.axis_value
	var suffix := "_minus" if axis_value == -1 else "_plus"
	return get("axis_" + str(axis) + suffix)
