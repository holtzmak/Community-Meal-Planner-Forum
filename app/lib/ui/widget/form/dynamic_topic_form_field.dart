import 'package:app/core/topic.dart';
import 'package:app/ui/widget/form/dynamic_form_field.dart';
import 'package:app/ui/widget/form/topic_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

/// A custom form field for List<Topic>.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
DynamicFormField<Topic> dynamicTopicFormField(
        {required List<Topic> initialList,
        required Function(List<Topic>) onSaved}) =>
    DynamicFormField<Topic>(
        initialList: initialList,
        titles: "Topic",
        onSaved: onSaved,
        blankFieldCreator: () => Topic.sustainablePractices,
        fieldCreator: (int index, Topic it, Function(int, Topic?) onSaved,
                Function(int) onDelete) =>
            TopicFormField(
              // Must have unique keys in rebuilding widget lists
              key: ObjectKey(Uuid().v4()),
              initialValue: it,
              onSaved: (Topic? changed) => onSaved(index, changed),
              onDelete: () => onDelete(index),
            ));
