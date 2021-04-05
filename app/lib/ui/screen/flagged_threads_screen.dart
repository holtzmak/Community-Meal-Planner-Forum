import 'package:app/core/thread_flag.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/specific_item_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/flagged_thread_preview_card.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FlaggedThreadsScreen<T extends SpecificItemViewModel>
    extends StatefulWidget {
  static const route = '/flaggedThreads';

  const FlaggedThreadsScreen({Key? key}) : super(key: key);

  @override
  _FlaggedThreadsScreenState<T> createState() =>
      _FlaggedThreadsScreenState<T>();
}

class _FlaggedThreadsScreenState<T extends SpecificItemViewModel>
    extends State<FlaggedThreadsScreen<T>> {
  FlaggedThreadPreviewCard createPreview(ThreadFlag threadFlag) =>
      FlaggedThreadPreviewCard(
        // Must have unique keys in rebuilding widget lists
        key: ObjectKey(Uuid().v4()),
        threadFlag: threadFlag,
      );

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<T>(
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
