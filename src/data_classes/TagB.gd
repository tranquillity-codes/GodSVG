class_name TagB extends Tag  # B as in branch.

signal child_tag_attribute_changed
signal tag_added
signal tag_deleted(tag_idx: int)
signal tag_moved
signal changed_unknown

var child_tags: Array[Tag]

func add_tag(new_tag: Tag) -> void:
	child_tags.append(new_tag)
	new_tag.attribute_changed.connect(emit_child_tag_attribute_changed)
	tag_added.emit()

func replace_tags(new_tags: Array[Tag]) -> void:
	child_tags.clear()
	for tag in new_tags:
		child_tags.append(tag)
		tag.attribute_changed.connect(emit_child_tag_attribute_changed)
	changed_unknown.emit()

func delete_tag(idx: int) -> void:
	if idx >= 0:
		child_tags.remove_at(idx)
		tag_deleted.emit(idx)

func move_tag(old_idx: int, new_idx: int) -> void:
	var tag: Tag = child_tags.pop_at(old_idx)  # Should be inferrable, GDScript bug.
	child_tags.insert(new_idx, tag)
	tag_moved.emit()


func emit_child_tag_attribute_changed() -> void:
	child_tag_attribute_changed.emit()

func get_children_count() -> int:
	return child_tags.size()