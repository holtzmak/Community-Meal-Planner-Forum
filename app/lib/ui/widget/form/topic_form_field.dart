import 'package:app/core/topic.dart';
import 'package:flutter/material.dart';

class TopicFormField extends FormField<Topic> {
  TopicFormField(
      {Key? key,
      required Topic initialValue,
      required FormFieldSetter<Topic> onSaved,
      required Function()? onDelete,
      bool isMultiline = false})
      : super(
            key: key,
            initialValue: initialValue,
            builder: (FormFieldState<Topic> state) {
              return _CustomFormField(
                state: state,
                onSaved: onSaved,
                onDelete: onDelete,
              );
            });
}

class _CustomFormField extends StatefulWidget {
  final FormFieldState<Topic> state;
  final Function()? onDelete;
  final FormFieldSetter<Topic> onSaved;

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
                  border: OutlineInputBorder(), labelText: "Topic"),
              value: TopicString.toDisplayString(widget.state.value!),
              items: [
                "Sustainable practices",
                "Tools",
                "Recipes",
                "General practices",
                "Education"
              ]
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (String? changed) => setState(() =>
                  widget.onSaved(TopicString.fromDisplayString(changed!))),
              onSaved: (String? changed) => setState(() =>
                  widget.onSaved(TopicString.fromDisplayString(changed!))),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever, size: 40.0),
              onPressed: widget.onDelete,
            ))
        : ListTile(
            title: DropdownButtonFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Topic"),
            value: TopicString.toDisplayString(widget.state.value!),
            items: [
              "Sustainable practices",
              "Tools",
              "Recipes",
              "General practices",
              "Education"
            ]
                .map((label) => DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    ))
                .toList(),
            onChanged: (String? changed) => setState(
                () => widget.onSaved(TopicString.fromDisplayString(changed!))),
            onSaved: (String? changed) => setState(
                () => widget.onSaved(TopicString.fromDisplayString(changed!))),
          ));
  }
}
