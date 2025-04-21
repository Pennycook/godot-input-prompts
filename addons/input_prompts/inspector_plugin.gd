# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
extends EditorInspectorPlugin


func _can_handle(object: Object) -> bool:
	var types := [
		ActionPrompt, JoypadButtonPrompt, JoypadMotionPrompt, KeyPrompt, MouseButtonPrompt
	]
	return types.any(func(t) -> bool: return is_instance_of(object, t))


func _parse_property(
	_object: Object, _type: Variant.Type, name: String,
	_hint_type: PropertyHint, _hint_string: String,
	_usage_flags, _wide: bool) -> bool:
	# Hide the texture property of TextureRect to ensure that user can only
	# modify it indirectly (e.g. via setting key, button, action or icon)
	return name == "texture"
