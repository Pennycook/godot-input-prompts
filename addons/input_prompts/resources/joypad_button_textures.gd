# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
class_name JoypadButtonTextures
extends Resource

@export var button_0: Texture2D = null
@export var button_1: Texture2D = null
@export var button_2: Texture2D = null
@export var button_3: Texture2D = null
@export var button_4: Texture2D = null
@export var button_5: Texture2D = null
@export var button_6: Texture2D = null
@export var button_7: Texture2D = null
@export var button_8: Texture2D = null
@export var button_9: Texture2D = null
@export var button_10: Texture2D = null
@export var button_11: Texture2D = null
@export var button_12: Texture2D = null
@export var button_13: Texture2D = null
@export var button_14: Texture2D = null
@export var button_15: Texture2D = null
@export var button_16: Texture2D = null
@export var button_17: Texture2D = null
@export var button_18: Texture2D = null
@export var button_19: Texture2D = null
@export var button_20: Texture2D = null


func get_texture(button: int) -> Texture2D:
	return get("button_" + str(button))
