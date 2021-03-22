import 'package:app/service/validator_service.dart';
import 'package:app/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildTapToEditTextFormField({
  required String label,
  required bool isReadOnly,
  required FocusNode focusNode,
  required TextEditingController controller,
  required FormFieldSetter<String> onSaved,
  required VoidCallback onTap,
}) {
  return isReadOnly
      ? GestureDetector(
          onTap: onTap,
          child: outlinedBox(
              child: Text(
                controller.text,
                style: GoogleFonts.raleway(
                    color: Charcoal, fontSize: MediumTextSize),
              ),
              childAlignmentInBox: Alignment.topLeft,
              color: Charcoal))
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
            decoration: InputDecoration(
                errorStyle: GoogleFonts.notoSerif(color: BurntSienna),
                border: OutlineInputBorder(),
                labelText: label),
          ));
}

Widget buildTapToEditMultilineTextFormField({
  required String label,
  required bool isReadOnly,
  required FocusNode focusNode,
  required TextEditingController controller,
  required FormFieldSetter<String> onSaved,
  required VoidCallback onTap,
}) {
  return isReadOnly
      ? GestureDetector(
          onTap: onTap,
          child: outlinedBox(
              child: Text(
                controller.text,
                style: GoogleFonts.raleway(
                    color: Charcoal, fontSize: MediumTextSize),
              ),
              childAlignmentInBox: Alignment.topLeft,
              color: Charcoal))
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
            maxLines: 3,
            decoration: InputDecoration(
                errorStyle: GoogleFonts.notoSerif(color: BurntSienna),
                border: OutlineInputBorder(),
                labelText: label),
          ));
}
