import 'package:app/core/subtopic.dart';
import 'package:app/core/thread.dart';
import 'package:app/core/topic.dart';
import 'package:app/service/dialog_service.dart';
import 'package:app/service/firebase_database_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/style.dart';
import 'package:app/ui/widget/form/dynamic_form_field.dart';
import 'package:app/ui/widget/form/dynamic_sub_topic_form_field.dart';
import 'package:app/ui/widget/form/dynamic_topic_form_field.dart';
import 'package:app/ui/widget/form/tap_to_edit_text_form_field.dart';
import 'package:flutter/material.dart';

class ThreadWidget extends StatefulWidget {
  final FirebaseDatabaseService _databaseService =
      ServiceLocator.get<FirebaseDatabaseService>();
  final DialogService _dialogService = ServiceLocator.get<DialogService>();
  final Thread initial;
  final bool canBeEdited;
  final FormFieldSetter<Thread>? onSaved;

  ThreadWidget({
    Key? key,
    required this.initial,
    required this.canBeEdited,
    this.onSaved,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ThreadWidgetState();
}

class _ThreadWidgetState extends State<ThreadWidget> {
  final focusNode = FocusNode();
  bool isReadOnly = true;
  late TextEditingController titleController;
  late List<Topic> topics;
  late DynamicFormField<Topic> topicFormField;
  late List<SubTopic> subTopics;
  late DynamicFormField<SubTopic> subTopicFormField;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.initial.title);
    topics = widget.initial.topics;
    topicFormField = dynamicTopicFormField(
        initialList: widget.initial.topics,
        onSaved: (List<Topic> changed) => topics = changed);
    subTopics = widget.initial.subTopics;
    subTopicFormField = dynamicSubTopicFormField(
        initialList: widget.initial.subTopics,
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
      widget.onSaved!(Thread(
          id: widget.initial.id,
          title: titleController.text.trim(),
          topics: topics,
          subTopics: subTopics,
          authorId: widget.initial.authorId,
          startDate: widget.initial.startDate,
          completionDate: widget.initial.completionDate,
          completionPost: widget.initial.completionPost,
          canBeRepliedTo: widget.initial.canBeRepliedTo));
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
            widget._databaseService.getUpdatedSpecificThread(widget.initial.id),
        initialData: widget.initial,
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
      _buildTopicsWidgets()
    ]);
  }

  Widget _buildTopicsWidgets() {
    if (widget.canBeEdited) {
      return Column(children: [
        ListTile(title: Text("Topics")),
        topicFormField,
        ListTile(title: Text("Sub-topics")),
        subTopicFormField,
        elevatedButton(
            text: "Submit",
            onPressed: saveAll,
            color: PersianGreen,
            pressedColor: PersianGreenOpaque)
      ]);
    } else {
      final List<Chip> children = [];
      children.addAll(
          List.generate(topics.length, (index) => _buildTopicChip(index)));
      children.addAll(List.generate(
          subTopics.length, (index) => _buildSubTopicChip(index)));
      return Column(children: children);
    }
  }

  Chip _buildTopicChip(int index) {
    return Chip(label: Text(TopicString.toDisplayString(topics[index])));
  }

  Chip _buildSubTopicChip(int index) {
    return Chip(label: Text(SubTopicString.toDisplayString(subTopics[index])));
  }
}
