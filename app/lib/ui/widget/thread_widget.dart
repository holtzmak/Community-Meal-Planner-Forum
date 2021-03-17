import 'package:app/core/thread.dart';
import 'package:app/service/firebase_database_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:flutter/material.dart';

class ThreadWidget extends StatefulWidget {
  final FirebaseDatabaseService _databaseService =
      ServiceLocator.get<FirebaseDatabaseService>();
  final Thread initial;
  final _formKey = GlobalKey<FormState>();

  void save() => _formKey.currentState!.save();

  bool validate() => _formKey.currentState!.validate();

  ThreadWidget({
    Key? key,
    required this.initial,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ThreadWidgetState();
}

class _ThreadWidgetState extends State<ThreadWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: Move this stream into ViewModel. Need to give the VM the thread to begin
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
            children.add(Text(snapshot.data.toString()));
          }
          if (snapshot.hasError) {
            children
                .add(Text("Something is wrong! ${snapshot.error.toString()}"));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          );
        });
  }
}
