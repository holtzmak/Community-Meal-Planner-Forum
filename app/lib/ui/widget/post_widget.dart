import 'package:app/service/validator_service.dart';
import 'package:app/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostWidget extends StatefulWidget {
  final String initial;
  final bool canBeEdited;
  final FormFieldSetter<String>? onSaved;
  final _formKey = GlobalKey<FormState>();

  void save() => _formKey.currentState!.save();

  bool validate() => _formKey.currentState!.validate();

  PostWidget(
      {Key? key,
      required this.initial,
      this.onSaved,
      required this.canBeEdited})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late TextEditingController messageController;
  final focusNode = FocusNode();
  bool isReadOnly = true;

  @override
  void initState() {
    messageController = TextEditingController(text: widget.initial);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: widget._formKey,
          child: Column(children: [
            ListTile(
              title: Text(
                "Message from: Account holder",
                style: GoogleFonts.raleway(color: Charcoal),
              ),
              subtitle: Text("Datetime now",
                  style: GoogleFonts.raleway(color: CharcoalOpaque)),
            ),
            _buildTextField(),
          ])),
    ));
  }

  Widget _buildTextField() {
    return isReadOnly
        ? GestureDetector(
            onTap: () => setState(() => isReadOnly = false),
            child: Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              decoration: BoxDecoration(border: Border.all(color: Charcoal)),
              child: Align(
                  heightFactor: 5,
                  alignment: Alignment.topLeft,
                  child: Text(messageController.text)),
            ))
        : Container(
            padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: TextFormField(
              autofocus: false,
              focusNode: focusNode,
              textInputAction: TextInputAction.done,
              readOnly: isReadOnly,
              controller: messageController,
              onSaved: widget.onSaved,
              onEditingComplete: () {
                widget.onSaved;
                setState(() => isReadOnly = true);
              },
              validator: ValidatorService.emptyValidator,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: InputDecoration(
                  errorStyle: GoogleFonts.notoSerif(color: BurntSienna),
                  border: OutlineInputBorder(),
                  labelText: "Type a message here"),
            ));
  }
}
