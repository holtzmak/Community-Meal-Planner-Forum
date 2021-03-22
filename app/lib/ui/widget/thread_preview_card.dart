import 'package:app/core/thread.dart';
import 'package:app/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThreadPreviewCard extends StatefulWidget {
  final Thread thread;

  final GestureTapCallback onTap;

  ThreadPreviewCard({Key? key, required this.thread, required this.onTap})
      : super(key: key);

  @override
  _ThreadPreviewCardState createState() => _ThreadPreviewCardState();
}

class _ThreadPreviewCardState extends State<ThreadPreviewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(
        'Question',
        style: GoogleFonts.raleway(
            color: CharcoalOpaque, fontSize: BodyTextSize, letterSpacing: 1.1),
      ),
      subtitle: Text(
        widget.thread.title,
        style: GoogleFonts.cabin(color: Charcoal, fontSize: MediumTextSize),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(
        Icons.connect_without_contact_outlined,
        size: 50,
      ),
      onTap: widget.onTap,
    ));
  }
}
