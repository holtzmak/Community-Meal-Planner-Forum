import 'package:app/core/administration_application.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/applications_to_review_view_model.dart';
import 'package:app/ui/widget/application_preview_card.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ApplicationsToReviewScreen extends StatefulWidget {
  static const route = '/applicationsToReview';

  const ApplicationsToReviewScreen({Key? key}) : super(key: key);

  @override
  _ApplicationsToReviewScreenState createState() =>
      _ApplicationsToReviewScreenState();
}

class _ApplicationsToReviewScreenState
    extends State<ApplicationsToReviewScreen> {
  ApplicationPreviewCard createPreview(AdministrationApplication application) =>
      ApplicationPreviewCard(
        // Must have unique keys in rebuilding widget lists
        key: ObjectKey(Uuid().v4()),
        application: application,
      );

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<ApplicationsToReviewViewModel>(
      builder: (context, model, _) => Scaffold(
        appBar: customAppBar(
            leftButtonText: "Account",
            centreButtonText: "Home",
            rightButtonText: "FAQ",
            leftButtonAction: () {
              // TODO
            },
            centreButtonAction: model.navigateToHomeScreen,
            rightButtonAction: () {
              // TODO
            }),
        bottomNavigationBar: CustomBottomAppBar.get(),
        body: model.items.isEmpty
            ? Center(
                child: Container(
                margin: EdgeInsets.all(50.0),
                child: Card(
                  child: ListTile(
                    title: Text(
                      "There is no information to show yet",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: LargeTextSize),
                    ),
                  ),
                ),
              ))
            : ListView.builder(
                itemCount: model.items.length,
                itemBuilder: (context, index) =>
                    createPreview(model.items[index]),
              ),
      ),
    );
  }
}
