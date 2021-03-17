import 'package:app/core/subtopic.dart';
import 'package:flutter/material.dart';

class SubTopicFormField extends FormField<SubTopic> {
  SubTopicFormField(
      {Key? key,
      required SubTopic initialValue,
      required FormFieldSetter<SubTopic> onSaved,
      required Function()? onDelete,
      bool isMultiline = false})
      : super(
            key: key,
            initialValue: initialValue,
            builder: (FormFieldState<SubTopic> state) {
              return _CustomFormField(
                state: state,
                onSaved: onSaved,
                onDelete: onDelete,
              );
            });
}

class _CustomFormField extends StatefulWidget {
  final FormFieldState<SubTopic> state;
  final Function()? onDelete;
  final FormFieldSetter<SubTopic> onSaved;

  const _CustomFormField(
      {Key? key,
      required this.state,
      required this.onDelete,
      required this.onSaved})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<_CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return widget.onDelete != null
        ? ListTile(
            title: DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Sub-topic"),
                value: SubTopicString.toDisplayString(widget.state.value!),
                items: [
                  "Critique",
                  "Praise",
                  "General discussion",
                  "Suggestions",
                ]
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (String? changed) => setState(() => widget
                    .onSaved(SubTopicString.fromDisplayString(changed!)))),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever, size: 40.0),
              onPressed: widget.onDelete,
            ))
        : ListTile(
            title: DropdownButtonFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Sub-topic"),
            value: SubTopicString.toDisplayString(widget.state.value!),
            items: [
              "Critique",
              "Praise",
              "General discussion",
              "Suggestions",
            ]
                .map((label) => DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    ))
                .toList(),
            onChanged: (String? changed) => setState(() =>
                widget.onSaved(SubTopicString.fromDisplayString(changed!))),
          ));
  }
}
