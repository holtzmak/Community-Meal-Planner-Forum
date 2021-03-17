import 'package:app/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StringFormField extends FormField<String> {
  StringFormField(
      {Key? key,
      required String initialValue,
      required String title,
      required FormFieldSetter<String> onSaved,
      required Function()? onDelete,
      required FormFieldValidator<String> validator,
      bool isMultiline = false})
      : super(
            key: key,
            initialValue: initialValue,
            builder: (FormFieldState<String> state) {
              return _CustomFormFieldState(
                state: state,
                title: title,
                isMultiline: isMultiline,
                onSaved: onSaved,
                onDelete: onDelete,
                validator: validator,
              );
            });
}

class _CustomFormFieldState extends StatelessWidget {
  final FormFieldState<String> state;
  final String title;
  final bool isMultiline;
  final Function()? onDelete;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  _CustomFormFieldState({
    required this.state,
    required this.title,
    required this.isMultiline,
    required this.onDelete,
    required this.onSaved,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return onDelete != null
        ? ListTile(
            title: TextFormField(
              validator: validator,
              initialValue: state.value,
              decoration: InputDecoration(
                  errorStyle: GoogleFonts.notoSerif(color: BurntSienna),
                  border: OutlineInputBorder(),
                  labelText: title),
              keyboardType:
                  isMultiline ? TextInputType.multiline : TextInputType.text,
              // Needed for the text field to expand
              maxLines: null,
              onSaved: onSaved,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever, size: 40.0),
              onPressed: onDelete,
            ))
        : ListTile(
            title: TextFormField(
            validator: validator,
            initialValue: state.value,
            decoration: InputDecoration(
                errorStyle: GoogleFonts.notoSerif(color: BurntSienna),
                border: OutlineInputBorder(),
                labelText: title),
            keyboardType:
                isMultiline ? TextInputType.multiline : TextInputType.text,
            // Needed for the text field to expand
            maxLines: null,
            onSaved: onSaved,
          ));
  }
}
