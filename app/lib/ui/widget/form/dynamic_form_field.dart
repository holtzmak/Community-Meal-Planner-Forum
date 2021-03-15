import 'package:flutter/material.dart';

/// A custom form field for List<T>. Requires widget builder W.
/// Due to it's dynamic nature this widget should only be used inside a grow-able
/// widget, like column, and not inside static widgets like ListTiles.
class DynamicFormField<T> extends StatefulWidget {
  final List<T> initialList;
  final String titles;
  final Function(List<T>) onSaved;
  final T Function() blankFieldCreator;
  final FormField<T> Function(int, T, Function(int, T?), Function(int))
      fieldCreator;
  final _formKey = GlobalKey<FormState>();

  void save() => _formKey.currentState!.save();

  bool validate() => _formKey.currentState!.validate();

  DynamicFormField(
      {Key? key,
      required this.initialList,
      required this.titles,
      required this.blankFieldCreator,
      required this.fieldCreator,
      required this.onSaved})
      : super(key: key);

  @override
  _DynamicFormFieldState<T> createState() => _DynamicFormFieldState<T>();
}

class _DynamicFormFieldState<T> extends State<DynamicFormField<T>> {
  final List<T> _fields = [];

  void _saveIndividual(int index, T? field) {
    if (field != null) {
      _fields[index] = field;
      widget.onSaved(_fields);
    }
  }

  void _deleteField(int index) => setState(() {
        widget.save();
        _fields.removeAt(index);
      });

  void _addField() => setState(() {
        widget.save();
        _fields.add(widget.blankFieldCreator());
      });

  FormField<T> _createField(int index) {
    return widget.fieldCreator(
        index, _fields[index], _saveIndividual, _deleteField);
  }

  @override
  void initState() {
    _fields.addAll(widget.initialList.cast<T>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget._formKey,
        child: Column(
          children: [
            if (_fields.isEmpty == false)
              Column(
                  children: List<FormField<T>>.generate(
                      _fields.length, (index) => _createField(index))),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.add_circle_rounded,
                  size: 30.0,
                ),
                onPressed: _addField,
              ),
            ),
          ],
        ));
  }
}
