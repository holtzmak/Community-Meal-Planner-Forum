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

class NewAnnouncementViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final _firebaseAuthService = ServiceLocator.get<FirebaseAuthService>();
  final _databaseService = ServiceLocator.get<FirebaseDatabaseService>();
  final _dialogService = ServiceLocator.get<DialogService>();

  Future<void> updateAnnouncementThread(Thread thread) async => _databaseService
      .updateAnnouncementThread(thread)
      .catchError((error) => _dialogService.showDialog(
            title: 'Updating your announcement failed!',
            description: "Here's what we think went wrong:\n${error.message}",
          ));

  Future<void> updatePostInAnnouncementThread(Thread thread, Post post) async =>
      _databaseService
          .updatePostInAnnouncementThread(thread, post)
          .catchError((error) => _dialogService.showDialog(
                title: 'Updating your message failed!',
                description:
                    "Here's what we think went wrong:\n${error.message}",
              ));

  Future<Post> addNewPostToAnnouncementThread(Thread thread) async {
    final thisUser = _firebaseAuthService.currentUser;
    return (thisUser != null && _firebaseAuthService.currentUserIsAdmin)
        ? _databaseService
            .getAccount(thisUser.uid)
            .then((Account account) =>
                _databaseService.addPostToAnnouncementThread(
                    thread,
                    Post(
                        id: "",
                        authorName: account.name,
                        authorId: account.id,
                        message: "Type your question here",
                        postDate: DateTime.now())))
            .catchError((error) => Future<Post>.error(
                "Adding your message failed!\nHere's what we think went wrong:\n${error.message}"))
        : Future<Post>.error("Cannot create a post when not logged in!");
  }

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);
}
