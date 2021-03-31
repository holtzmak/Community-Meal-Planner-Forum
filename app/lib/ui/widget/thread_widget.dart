import 'package:app/core/flag_reason.dart';
import 'package:app/core/subtopic.dart';
import 'package:app/core/thread.dart';
import 'package:app/core/thread_flag.dart';
import 'package:app/core/topic.dart';
import 'package:app/service/dialog_service.dart';
import 'package:app/service/firestore_admin_service.dart';
import 'package:app/service/firestore_announcement_service.dart';
import 'package:app/service/firestore_thread_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/service/template_firestore_thread_service.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/widget/form/dynamic_form_field.dart';
import 'package:app/ui/widget/form/dynamic_sub_topic_form_field.dart';
import 'package:app/ui/widget/form/dynamic_topic_form_field.dart';
import 'package:app/ui/widget/form/tap_to_edit_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThreadWidget extends StatefulWidget {
  final TemplateFirestoreThreadService _threadService;
  final _adminService = ServiceLocator.get<FirestoreAdminService>();
  final _dialogService = ServiceLocator.get<DialogService>();
  final Thread thread;
  final bool canBeEdited;
  final FormFieldSetter<Thread>? onSaved;

  ThreadWidget({
    Key? key,
    required this.thread,
    required this.canBeEdited,
    this.onSaved,
  })  : _threadService = thread.isAnnouncement
            ? ServiceLocator.get<FirestoreAnnouncementService>()
            : ServiceLocator.get<FirestoreThreadService>(),
        super(key: key);

  @override
  State<ThreadWidget> createState() => _ThreadWidgetState();
}

class _ThreadWidgetState extends State<ThreadWidget> {
  final focusNode = FocusNode();
  bool isReadOnly = true;
  late bool canBeRepliedTo;
  late TextEditingController titleController;
  late List<Topic> topics;
  late DynamicFormField<Topic> topicFormField;
  late List<SubTopic> subTopics;
  late DynamicFormField<SubTopic> subTopicFormField;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.thread.title);
    canBeRepliedTo = widget.thread.canBeRepliedTo;
    topics = widget.thread.topics;
    topicFormField = dynamicTopicFormField(
        initialList: widget.thread.topics,
        onSaved: (List<Topic> changed) => topics = changed);
    subTopics = widget.thread.subTopics;
    subTopicFormField = dynamicSubTopicFormField(
        initialList: widget.thread.subTopics,
        onSaved: (List<SubTopic> changed) => subTopics = changed);
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void saveAll() {
    if (widget.onSaved != null) {
      topicFormField.save();
      subTopicFormField.save();
      widget.onSaved!(Thread(
          id: widget.thread.id,
          title: titleController.text.trim(),
          topics: topics,
          subTopics: subTopics,
          authorId: widget.thread.authorId,
          startDate: widget.thread.startDate,
          completionDate: widget.thread.completionDate,
          completionPost: widget.thread.completionPost,
          canBeRepliedTo: canBeRepliedTo,
          isAnnouncement: widget.thread.isAnnouncement));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Move this stream into ViewModel. Need to give the VM the initial thread
    // Unfortunately, this widget and it's behaviour are tightly coupled to the
    // database service such that a view model cannot be between as the design
    // is now (requires a given Thread to start)
    return StreamBuilder<Thread>(
        stream:
            widget._threadService.getUpdatedSpecificThread(widget.thread.id),
        initialData: widget.thread,
        builder: (BuildContext context, AsyncSnapshot<Thread> snapshot) {
          List<Widget> children = [];
          if (snapshot.hasData) {
            children.add(_buildThreadWidget());
          } else if (snapshot.hasError) {
            children.add(Text("There is no information to show"));
            widget._dialogService.showDialog(
              title: 'Getting information for you failed!',
              description:
                  "Here's what we think went wrong:\n${snapshot.error.toString()}",
            );
          } else {
            children.add(Text("There is no information to show"));
            widget._dialogService.showDialog(
              title: 'Getting information for you failed!',
              description:
                  "Here's what we think went wrong:\nThe database did not return anything or there was no question to begin with. You might see this if something is wrong with this application's screens.",
            );
          }
          return Column(children: children);
        });
  }

  Widget _buildThreadWidget() {
    return Column(children: [
      widget.canBeEdited
          ? ListTile(title: Text("Title"))
          : ListTile(
              title: Text("Title"),
              trailing: _buildFlagMenu(),
            ),
      buildTapToEditTextFormField(
          label: "Type your question title here",
          isReadOnly: isReadOnly || !widget.canBeEdited,
          focusNode: focusNode,
          controller: titleController,
          onSaved: (String? _) {
            saveAll();
            setState(() => isReadOnly = true);
          },
          onTap: () => setState(() => isReadOnly = false)),
      _buildTopicsWidgets(),
      if (widget.canBeEdited && widget.thread.isAnnouncement)
        ListTile(
          title: Text("Anyone can reply to this thread"),
          trailing: _buildReplyToggle(),
        ),
      if (widget.canBeEdited)
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
            stretchedButton(
                text: "Save any title or topic changes",
                onPressed: saveAll,
                color: PersianGreen,
                pressedColor: PersianGreenOpaque,
                trailing: Icon(
                  Icons.check_circle,
                  size: 40.0,
                ))
          ],
        )
    ]);
  }

  Widget _buildTopicsWidgets() {
    if (widget.canBeEdited) {
      return Column(children: [
        ListTile(title: Text("Topics")),
        topicFormField,
        ListTile(title: Text("Sub-topics")),
        subTopicFormField,
      ]);
    } else {
      final List<Widget> children = [];
      children.add(ListTile(title: Text("Topics")));
      children.addAll(
          List.generate(topics.length, (index) => _buildTopicChip(index)));
      children.add(ListTile(title: Text("Sub-topics")));
      children.addAll(List.generate(
          subTopics.length, (index) => _buildSubTopicChip(index)));
      return Column(children: children);
    }
  }

  Widget _buildTopicChip(int index) {
    return Container(
        margin: EdgeInsets.only(left: 16.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child:
                Chip(label: Text(TopicString.toDisplayString(topics[index])))));
  }

  Widget _buildSubTopicChip(int index) {
    return Container(
        margin: EdgeInsets.only(left: 16.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Chip(
                label:
                    Text(SubTopicString.toDisplayString(subTopics[index])))));
  }

  Widget _buildReplyToggle() {
    return CupertinoSwitch(
        activeColor: PersianGreen,
        value: canBeRepliedTo,
        onChanged: (bool changed) {
          if (widget.canBeEdited) {
            canBeRepliedTo = changed;
            setState(() => isReadOnly = changed);
          }
        });
  }

  Widget _buildFlagMenu() {
    return PopupMenuButton<FlagReason>(
        icon: Icon(
          Icons.warning,
          size: 30.0,
        ),
        onSelected: (FlagReason reason) =>
            widget._adminService.addThreadFlag(ThreadFlag(
                // Unused ID here, used in other screens
                id: "unused",
                threadId: widget.thread.id,
                isAnnouncement: widget.thread.isAnnouncement,
                flagReason: reason)),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<FlagReason>>[
              PopupMenuItem<FlagReason>(
                value: FlagReason.unsure,
                child: Text('Something is wrong'),
              ),
              PopupMenuItem<FlagReason>(
                value: FlagReason.incorrectInformation,
                child: Text('This information is wrong'),
              ),
              PopupMenuItem<FlagReason>(
                value: FlagReason.incorrectLabel,
                child: Text('This is labelled wrong'),
              ),
              PopupMenuItem<FlagReason>(
                value: FlagReason.policyViolation,
                child: Text('This violates policy'),
              ),
            ]);
  }
}
