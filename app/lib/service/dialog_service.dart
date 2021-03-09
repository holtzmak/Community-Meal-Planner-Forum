import 'dart:async';

import 'package:flutter/material.dart';

class DialogRequest {
  final String title;
  final String description;
  final String buttonText;
  final String? cancelText;

  DialogRequest(
      {required this.title,
      required this.description,
      required this.buttonText,
      this.cancelText});
}

class DialogResponse {
  final String? fieldOne;
  final String? fieldTwo;
  final bool? confirmed;

  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
  });
}

/// A useful service created by FilledStacks:
/// https://www.filledstacks.com/post/manager-your-flutter-dialogs-with-a-dialog-manager/
class DialogService {
  final _dialogNavigationKey = GlobalKey<NavigatorState>();
  late Function(DialogRequest) _showDialogListener;
  Completer<DialogResponse>? _dialogCompleter;

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<DialogResponse> showDialog({
    required String title,
    required String description,
    String buttonText = 'Ok',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
      title: title,
      description: description,
      buttonText: buttonText,
    ));
    return _dialogCompleter!.future;
  }

  Future<DialogResponse> showConfirmationDialog(
      {required String title,
      required String description,
      String confirmationText = 'Ok',
      String cancelText = 'Cancel'}) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
        title: title,
        description: description,
        buttonText: confirmationText,
        cancelText: cancelText));
    return _dialogCompleter!.future;
  }

  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState!.pop();
    _dialogCompleter!.complete(response);
    _dialogCompleter = null;
  }
}
