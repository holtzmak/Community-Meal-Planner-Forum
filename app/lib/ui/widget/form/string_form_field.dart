import 'package:app/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A custom FormField<String> with onSaved and onDelete callback
class StringFormField extends StatefulWidget {
  final String initial;
  final String title;
  final bool isMultiline;
  final FormFieldSetter<String> onSaved;
  final Function()? onDelete;
  final FormFieldValidator<String> validator;

  // TODO: Rework this class so as to be able to call validate, save on it
  StringFormField(
      {Key? key,
      required this.initial,
      required this.title,
      required this.onSaved,
      required this.validator,
      this.onDelete,
      this.isMultiline = false})
      : super(key: key);

  @override
  _StringFormFieldState createState() => _StringFormFieldState();
}

class _StringFormFieldState extends State<StringFormField> {
  @override
  Widget build(BuildContext context) {
    return widget.onDelete != null
        ? ListTile(
            title: TextFormField(
              validator: widget.validator,
              decoration: InputDecoration(
                  errorStyle: GoogleFonts.roboto(color: BurntSienna),
                  border: OutlineInputBorder(),
                  labelText: widget.title),
              keyboardType: widget.isMultiline
                  ? TextInputType.multiline
                  : TextInputType.text,
              // Needed for the text field to expand
              maxLines: null,
              initialValue: widget.initial,
              onChanged: widget.onSaved,
              onSaved: widget.onSaved,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever, size: 40.0),
              onPressed: widget.onDelete,
            ),
          )
        : ListTile(
            title: TextFormField(
              validator: widget.validator,
              decoration: InputDecoration(
                  errorStyle: GoogleFonts.roboto(color: BurntSienna),
                  border: OutlineInputBorder(),
                  labelText: widget.title),
              keyboardType: widget.isMultiline
                  ? TextInputType.multiline
                  : TextInputType.text,
              // Needed for the text field to expand
              maxLines: null,
              initialValue: widget.initial,
              onSaved: widget.onSaved,
              onChanged: widget.onSaved,
            ),
          );
  }
}
