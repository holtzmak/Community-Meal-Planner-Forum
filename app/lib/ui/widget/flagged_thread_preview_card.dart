import 'package:app/core/flag_reason.dart';
import 'package:app/core/thread.dart';
import 'package:app/core/thread_flag.dart';
import 'package:app/service/firestore_announcement_service.dart';
import 'package:app/service/firestore_thread_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/service/template_firestore_thread_service.dart';
import 'package:app/ui/screen/thread_display_screen.dart';
import 'package:app/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlaggedThreadPreviewCard extends StatefulWidget {
  final TemplateFirestoreThreadService _threadService;
  final _navigationService = ServiceLocator.get<NavigationService>();
  final ThreadFlag threadFlag;

  FlaggedThreadPreviewCard({Key? key, required this.threadFlag})
      : _threadService = threadFlag.isAnnouncement
            ? ServiceLocator.get<FirestoreAnnouncementService>()
            : ServiceLocator.get<FirestoreThreadService>(),
        super(key: key);

  @override
  _FlaggedThreadPreviewCardState createState() =>
      _FlaggedThreadPreviewCardState();
}

class _FlaggedThreadPreviewCardState extends State<FlaggedThreadPreviewCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: Move this stream into ViewModel. Need to give the VM the initial thread flag
    // Unfortunately, this widget and it's behaviour are tightly coupled to the
    // database service such that a view model cannot be between as the design
    // is now (requires a given ThreadFlag to start)
    return StreamBuilder<Thread>(
        stream: widget._threadService
            .getUpdatedSpecificThread(widget.threadFlag.threadId),
        builder: (BuildContext context, AsyncSnapshot<Thread> snapshot) {
          if (snapshot.hasData) {
            return _buildPreviewCard(snapshot.data!);
          } else if (snapshot.hasError) {
            return outlinedBox(
                child: Text(
                  snapshot.error.toString(),
                  style: GoogleFonts.raleway(
                      color: Colors.red, fontSize: MediumTextSize),
                ),
                childAlignmentInBox: Alignment.center,
                color: Colors.red);
          } else {
            return outlinedBox(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(PersianGreen)),
                childAlignmentInBox: Alignment.center,
                color: PersianGreen);
          }
        });
  }

  Widget _buildPreviewCard(Thread thread) => Card(
          child: Column(children: [
        ListTile(
          title: Text(
            FlagReasonString.toDisplayString(widget.threadFlag.flagReason),
            style: GoogleFonts.raleway(
                color: CharcoalOpaque,
                fontSize: BodyTextSize,
                letterSpacing: 1.1),
          ),
          subtitle: Text(
            thread.title,
            style: GoogleFonts.cabin(color: Charcoal, fontSize: MediumTextSize),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(
            Icons.warning,
            size: 50,
          ),
          onTap: () => widget._navigationService
              .navigateTo(ThreadDisplayScreen.route, arguments: thread),
        ),
        Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                elevatedButton(
                    text: "Finished",
                    onPressed: () {
                      // TODO
                    },
                    color: PersianGreen,
                    pressedColor: PersianGreenOpaque),
                Spacer(),
                outlinedButton(
                  text: "Delete",
                  onPressed: () {
                    // TODO
                  },
                  color: Colors.grey,
                )
              ],
            ))
      ]));
}
