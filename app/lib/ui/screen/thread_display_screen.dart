import 'package:app/core/post.dart';
import 'package:app/core/thread.dart';
import 'package:app/core/thread_to_display.dart';
import 'package:app/service/dialog_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/view_model/template_thread_view_model.dart';
import 'package:app/ui/widget/custom_app_bar.dart';
import 'package:app/ui/widget/custom_bottom_app_bar.dart';
import 'package:app/ui/widget/post_widget.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:app/ui/widget/thread_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThreadDisplayScreen<T extends TemplateThreadViewModel>
    extends StatefulWidget {
  final DialogService _dialogService = ServiceLocator.get<DialogService>();
  final ThreadToDisplay threadToDisplay;
  static const route = '/thread';

  ThreadDisplayScreen({Key? key, required this.threadToDisplay})
      : super(key: key);

  @override
  State<ThreadDisplayScreen<T>> createState() => _ThreadDisplayScreenState<T>();
}

class _ThreadDisplayScreenState<T extends TemplateThreadViewModel>
    extends State<ThreadDisplayScreen<T>> {
  late bool canBeRepliedTo;
  late bool isComplete;

  @override
  void initState() {
    canBeRepliedTo = widget.threadToDisplay.thread.canBeRepliedTo;
    isComplete = widget.threadToDisplay.thread.isComplete();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TemplateViewModel<T>(
        builder: (context, model, child) => Scaffold(
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
              body: Center(
                  child: SingleChildScrollView(
                      child: Column(
                children: _buildThreadAndPosts(model),
              ))),
            ));
  }

  List<Widget> _buildThreadAndPosts(T model) {
    final List<Widget> widgets = [];
    widgets.addAll([
      ThreadWidget(
        isAnnouncement: widget.threadToDisplay.isAnnouncement,
        initial: widget.threadToDisplay.thread,
        canBeEdited: model.userIsThreadOwner(widget.threadToDisplay.thread) &&
            !isComplete,
        onSaved: (Thread? thread) {
          if (thread != null) model.updateThread(thread);
        },
      ),
      Padding(padding: EdgeInsets.only(bottom: 20.0)),
      _buildPostsMaybe(model)
    ]);
    if (!isComplete && canBeRepliedTo && model.userIsLoggedIn()) {
      widgets.addAll([
        Padding(padding: EdgeInsets.only(bottom: 20.0)),
        Align(
            alignment: Alignment.centerRight,
            child: elevatedButton(
                text: "Add a reply",
                onPressed: () =>
                    model.addNewPostToThread(widget.threadToDisplay.thread),
                color: BurntSienna,
                pressedColor: BurntSiennaOpaque))
      ]);
    }
    return widgets;
  }

  Widget _buildPostsMaybe(T model) {
    // TODO: Move this stream into ViewModel. Need to give the VM the initial thread
    // Unfortunately, this widget and it's behaviour are tightly coupled to the
    // database service such that a view model cannot be between as the design
    // is now (requires a given Thread to start)
    return StreamBuilder<List<Post>>(
        stream:
            model.getUpdatedThreadSpecificPosts(widget.threadToDisplay.thread),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          List<Widget> children = [];
          if (snapshot.hasData) {
            children.addAll(List<PostWidget>.generate(
                snapshot.data!.length,
                (index) => PostWidget(
                      initial: snapshot.data![index],
                      isYourPost: model.userIsPostOwner(snapshot.data![index]),
                      canBeEdited:
                          model.userIsPostOwner(snapshot.data![index]) &&
                              !isComplete,
                      onSaved: (Post? post) {
                        if (post != null)
                          model.updatePostInThread(
                              widget.threadToDisplay.thread, post);
                      },
                    )));
          } else if (snapshot.hasError) {
            children.add(outlinedBox(
                child: Text("There is no information to show"),
                childAlignmentInBox: Alignment.centerLeft,
                color: Colors.red));
            widget._dialogService.showDialog(
              title: 'Getting information for you failed!',
              description:
                  "Here's what we think went wrong:\n${snapshot.error.toString()}",
            );
          } else {
            children.add(outlinedBox(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(PersianGreen)),
                childAlignmentInBox: Alignment.center,
                color: PersianGreen));
          }
          return Column(
            children: children,
          );
        });
  }
}
