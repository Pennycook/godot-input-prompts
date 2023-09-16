# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
class_name JoypadMotionTextures
extends Resource

@export var axis_0_minus: Texture2D = null
@export var axis_0_plus: Texture2D = null
@export var axis_1_minus: Texture2D = null
@export var axis_1_plus: Texture2D = null
@export var axis_2_minus: Texture2D = null
@export var axis_2_plus: Texture2D = null
@export var axis_3_minus: Texture2D = null
@export var axis_3_plus: Texture2D = null
@export var axis_4_minus: Texture2D = null
@export var axis_4_plus: Texture2D = null
@export var axis_5_minus: Texture2D = null
@export var axis_5_plus: Texture2D = null

func get_texture(axis: int, axis_value: int) -> Texture2D:
	var suffix := "_minus" if axis_value == -1 else "_plus"
	return get("axis_" + str(axis) + suffix)
