import 'package:app/service/validator_service.dart';
import 'package:app/ui/widget/form/string_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import 'dynamic_form_field.dart';

/// A custom form field for List<String>.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
DynamicFormField<String> dynamicStringFormField(
        {required List<String> initialList,
        required String titles,
        required Function(List<String>) onSaved}) =>
    DynamicFormField<String>(
        initialList: initialList,
        titles: titles,
        onSaved: onSaved,
        blankFieldCreator: () => "",
        fieldCreator: (int index, String it, Function(int, String?) onSaved,
                Function(int) onDelete) =>
            StringFormField(
              // Must have unique keys in rebuilding widget lists
              key: ObjectKey(Uuid().v4()),
              initialValue: it,
              title: titles,
              onSaved: (String? changed) => onSaved(index, changed),
              onDelete: () => onDelete(index),
              validator: ValidatorService.emptyValidator,
            ));
