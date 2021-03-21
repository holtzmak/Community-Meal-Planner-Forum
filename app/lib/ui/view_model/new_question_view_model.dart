import 'dart:async';

import 'package:app/core/account.dart';
import 'package:app/core/post.dart';
import 'package:app/core/thread.dart';
import 'package:app/service/dialog_service.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/firebase_database_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewQuestionViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final _firebaseAuthService = ServiceLocator.get<FirebaseAuthService>();
  final _databaseService = ServiceLocator.get<FirebaseDatabaseService>();
  final _dialogService = ServiceLocator.get<DialogService>();
  StreamSubscription<User?>? _currentUserSubscription;
  StreamSubscription<Account>? _accountSubscription;
  Account? _account;

  @mustCallSuper
  void dispose() {
    if (_currentUserSubscription != null) _currentUserSubscription!.cancel();
    _cancelAccountSubscription();
    super.dispose();
  }

  void _cancelAccountSubscription() {
    if (_currentUserSubscription != null) _accountSubscription!.cancel();
  }

  NewQuestionViewModel() {
    final thisUser = _firebaseAuthService.currentUser;
    if (thisUser != null) {
      _accountSubscription = _databaseService
          .getAccountUpdates(thisUser.uid)
          .listen((Account account) => _account = account);
      _currentUserSubscription =
          _firebaseAuthService.currentUserChanges.listen((User? user) {
        // User has logged out or is no longer authenticated, lock the ViewModel
        if (user == null) _cancelAccountSubscription();
      });
    } else {
      _dialogService.showDialog(
        title: 'Launching the new question screen failed',
        description: "You are not logged in!",
      );
    }
  }

  Future<void> updatePostInThread(Thread thread, Post post) async =>
      _databaseService
          .updatePostInThread(thread, post)
          .catchError((error) => _dialogService.showDialog(
                title: 'Updating your message failed!',
                description:
                    "Here's what we think went wrong:\n${error.message}",
              ));

  Future<Post> addNewPostToThread(Thread thread) async {
    if (_account != null) {
      final placeholder = Post(
          id: "",
          authorName: _account!.name,
          authorId: _account!.id,
          message: "Type your question here",
          postDate: DateTime.now());
      return _databaseService
          .addPostToThread(thread, placeholder)
          .catchError((error) {
        _dialogService.showDialog(
          title: 'Updating your message failed!',
          description: "Here's what we think went wrong:\n${error.message}",
        );
        return Future<Post>.error("Cannot create a post when not logged in!");
      });
    } else {
      _dialogService.showDialog(
          title: "Adding a new post to the thread failed",
          description: "Cannot create a post when not logged in!");
      return Future<Post>.error("Cannot create a post when not logged in!");
    }
  }

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);
}
