# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
class_name MouseButtonTextures
extends Resource

@export var button_1: Texture2D = null
@export var button_2: Texture2D = null
@export var button_3: Texture2D = null
@export var button_4: Texture2D = null
@export var button_5: Texture2D = null
@export var button_6: Texture2D = null
@export var button_7: Texture2D = null
@export var button_8: Texture2D = null
@export var button_9: Texture2D = null


func get_texture(button: int) -> Texture2D:
	return get("button_" + str(button))
