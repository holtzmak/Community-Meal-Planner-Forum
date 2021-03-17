import 'package:app/core/subtopic.dart';
import 'package:app/ui/widget/form/dynamic_form_field.dart';
import 'package:app/ui/widget/form/sub_topic_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

/// A custom form field for List<SubTopic>.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
DynamicFormField<SubTopic> dynamicSubTopicFormField(
        {required List<SubTopic> initialList,
        required Function(List<SubTopic>) onSaved}) =>
    DynamicFormField<SubTopic>(
        initialList: initialList,
        titles: "Sub-topic",
        onSaved: onSaved,
        blankFieldCreator: () => SubTopic.critique,
        fieldCreator: (int index, SubTopic it, Function(int, SubTopic?) onSaved,
                Function(int) onDelete) =>
            SubTopicFormField(
              // Must have unique keys in rebuilding widget lists
              key: ObjectKey(Uuid().v4()),
              initialValue: it,
              onSaved: (SubTopic? changed) => onSaved(index, changed),
              onDelete: () => onDelete(index),
            ));
