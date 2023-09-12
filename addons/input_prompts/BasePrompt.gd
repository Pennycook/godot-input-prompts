# Copyright (C) 2022 John Pennycook
# SPDX-License-Identifier: MIT
@tool
extends TextureRect

signal pressed()

func _is_input_prompt():
	return true

func _init():
	texture = AtlasTexture.new()
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

func _update_icon():
	pass

func _enter_tree():
	InputPrompts.icons_changed.connect(_update_icon)

func _exit_tree():
	InputPrompts.icons_changed.disconnect(_update_icon)
