import 'package:app/service/validator_service.dart';
import 'package:app/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildTapToEditTextFormField({
  required bool isReadOnly,
  required FocusNode focusNode,
  required TextEditingController controller,
  required FormFieldSetter<String> onSaved,
  required VoidCallback onTap,
}) {
  return isReadOnly
      ? GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Charcoal)),
            child: Align(
                alignment: Alignment.topLeft, child: Text(controller.text)),
          ))
      : Container(
          child: TextFormField(
          autofocus: false,
          focusNode: focusNode,
          textInputAction: TextInputAction.done,
          readOnly: isReadOnly,
          controller: controller,
          onFieldSubmitted: onSaved,
          validator: ValidatorService.emptyValidator,
          decoration: InputDecoration(
              errorStyle: GoogleFonts.notoSerif(color: BurntSienna),
              border: OutlineInputBorder(),
              labelText: "Type here"),
        ));
}

Widget buildTapToEditMultilineTextFormField({
  required bool isReadOnly,
  required FocusNode focusNode,
  required TextEditingController controller,
  required FormFieldSetter<String> onSaved,
  required VoidCallback onTap,
}) {
  return isReadOnly
      ? GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            decoration: BoxDecoration(border: Border.all(color: Charcoal)),
            child: Align(
                heightFactor: 5,
                alignment: Alignment.topLeft,
                child: Text(controller.text)),
          ))
      : Container(
          padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
          child: TextFormField(
            autofocus: false,
            focusNode: focusNode,
            textInputAction: TextInputAction.done,
            readOnly: isReadOnly,
            controller: controller,
            onFieldSubmitted: onSaved,
            validator: ValidatorService.emptyValidator,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            decoration: InputDecoration(
                errorStyle: GoogleFonts.notoSerif(color: BurntSienna),
                border: OutlineInputBorder(),
                labelText: "Type here"),
          ));
}
