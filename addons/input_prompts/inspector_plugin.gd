# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
extends EditorInspectorPlugin


func _can_handle(object):
	var types := [
		ActionPrompt, JoypadButtonPrompt, JoypadMotionPrompt, KeyPrompt, MouseButtonPrompt
	]
	return types.any(func(t): return is_instance_of(object, t))


func _parse_property(_object, _type, name, _hint_type, _hint_string, _usage_flags, _wide):
	# Hide the texture property of TextureRect to ensure that user can only
	# modify it indirectly (e.g. via setting key, button, action or icon)
	return name == "texture"
