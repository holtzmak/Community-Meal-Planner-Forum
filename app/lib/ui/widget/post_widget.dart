import 'package:app/core/post.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/widget/form/tap_to_edit_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final bool canBeEdited;
  final bool isYourPost;
  final FormFieldSetter<Post>? onSaved;

  PostWidget(
      {Key? key,
      required this.post,
      this.onSaved,
      required this.canBeEdited,
      required this.isYourPost})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late TextEditingController controller;
  final focusNode = FocusNode();
  bool isReadOnly = true;

  @override
  void initState() {
    controller = TextEditingController(text: widget.post.message);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            ListTile(
              title: Text(
                "${widget.post.authorName}",
                textAlign: widget.isYourPost ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.raleway(color: Charcoal),
              ),
              subtitle: Text(
                  DateFormat('yyyy-MM-dd hh:mm').format(widget.post.postDate),
                  textAlign:
                      widget.isYourPost ? TextAlign.right : TextAlign.left,
                  style: GoogleFonts.raleway(
                      color: CharcoalOpaque, fontSize: MediumTextSize)),
            ),
            buildTapToEditMultilineTextFormField(
                label: "Type your message here",
                isReadOnly: isReadOnly || !widget.canBeEdited,
                focusNode: focusNode,
                controller: controller,
                onSaved: (String? changed) {
                  if (widget.onSaved != null && changed != null)
                    widget.onSaved!(widget.post.withMessage(changed));
                  setState(() => isReadOnly = true);
                },
                onTap: () => setState(() => isReadOnly = false)),
          ])),
    );
  }
}
