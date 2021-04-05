import 'package:app/core/administration_application.dart';
import 'package:app/core/approval_status.dart';
import 'package:app/service/firestore_admin_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/application_review_screen.dart';
import 'package:app/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationPreviewCard extends StatefulWidget {
  final _adminService = ServiceLocator.get<FirestoreAdminService>();
  final _navigationService = ServiceLocator.get<NavigationService>();
  final AdministrationApplication application;

  ApplicationPreviewCard({Key? key, required this.application})
      : super(key: key);

  @override
  _ApplicationPreviewCardState createState() => _ApplicationPreviewCardState();
}

class _ApplicationPreviewCardState extends State<ApplicationPreviewCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: Move this stream into ViewModel. Need to give the VM the initial thread flag
    // Unfortunately, this widget and it's behaviour are tightly coupled to the
    // database service such that a view model cannot be between as the design
    // is now (requires a given ThreadFlag to start)
    return StreamBuilder<AdministrationApplication>(
        stream: widget._adminService
            .getUpdatedSpecificApplication(widget.application),
        builder: (BuildContext context,
            AsyncSnapshot<AdministrationApplication> snapshot) {
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

  Widget _buildPreviewCard(AdministrationApplication application) => Card(
          child: Column(children: [
        ListTile(
          title: Text(
            "Application to join leadership team",
            style: GoogleFonts.raleway(
                color: CharcoalOpaque,
                fontSize: BodyTextSize,
                letterSpacing: 1.1),
          ),
          subtitle: Text(
            application.applicantName,
            style: GoogleFonts.cabin(color: Charcoal, fontSize: MediumTextSize),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(
            Icons.account_circle,
            size: 50,
          ),
          onTap: () => widget._navigationService.navigateTo(
              ApplicationReviewScreen.route,
              arguments: application),
        ),
        Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                Spacer(),
                outlinedBox(
                    child: Text(ApprovalStatusString.toDisplayString(
                        application.approvalStatus)),
                    childAlignmentInBox: Alignment.center,
                    color: application.approvalStatus == ApprovalStatus.approved
                        ? PersianGreen
                        : Charcoal)
              ],
            ))
      ]));
}
