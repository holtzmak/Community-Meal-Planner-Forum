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
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<String> state) {
              return CustomFormFieldState(
                state: state,
                title: title,
                isMultiline: isMultiline,
                onSaved: onSaved,
                onDelete: onDelete,
              );
            });
}

class CustomFormFieldState extends StatelessWidget {
  final FormFieldState<String> state;
  final String title;
  final bool isMultiline;
  final Function()? onDelete;
  final FormFieldSetter<String> onSaved;

  CustomFormFieldState({
    required this.state,
    required this.title,
    required this.isMultiline,
    required this.onDelete,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
          title: TextFormField(
            initialValue: state.value,
            decoration:
                InputDecoration(border: OutlineInputBorder(), labelText: title),
            keyboardType:
                isMultiline ? TextInputType.multiline : TextInputType.text,
            // Needed for the text field to expand
            maxLines: null,
            onSaved: onSaved,
          ),
          trailing: onDelete != null
              ? IconButton(
                  icon: Icon(Icons.delete_forever, size: 40.0),
                  onPressed: onDelete,
                )
              : Container(),
        ),
        if (state.hasError)
          Padding(
            padding: EdgeInsets.only(top: 65),
            child: Text(
              state.errorText!,
              textAlign: TextAlign.left,
              style: GoogleFonts.notoSerif(color: BurntSienna),
            ),
          ),
      ],
    );
  }
}
