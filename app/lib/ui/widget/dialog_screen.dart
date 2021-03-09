import 'package:app/service/dialog_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:flutter/material.dart';

class DialogScreen extends StatefulWidget {
  final Widget child;

  DialogScreen({Key? key, required this.child}) : super(key: key);

  _DialogScreenState createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  DialogService _dialogService = ServiceLocator.get<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(request.title),
              content: Text(request.description),
              actions: <Widget>[
                if (request.cancelText != null)
                  TextButton(
                    child: Text(request.cancelText!),
                    onPressed: () {
                      _dialogService
                          .dialogComplete(DialogResponse(confirmed: false));
                    },
                  ),
                TextButton(
                  child: Text(request.buttonText),
                  onPressed: () {
                    _dialogService
                        .dialogComplete(DialogResponse(confirmed: true));
                  },
                ),
              ],
            ));
  }
}
