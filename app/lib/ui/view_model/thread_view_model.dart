import 'dart:async';

import 'package:app/core/account.dart';
import 'package:app/core/post.dart';
import 'package:app/core/thread.dart';
import 'package:app/service/dialog_service.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/firestore_account_service.dart';
import 'package:app/service/firestore_thread_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/screen/home_screen.dart';
import 'package:app/ui/widget/template_view_model.dart';

class ThreadViewModel extends ViewModel {
  final _navigationService = ServiceLocator.get<NavigationService>();
  final _firebaseAuthService = ServiceLocator.get<FirebaseAuthService>();
  final _accountService = ServiceLocator.get<FirestoreAccountService>();
  final _threadService = ServiceLocator.get<FirestoreThreadService>();
  final _dialogService = ServiceLocator.get<DialogService>();

  bool userIsLoggedIn() => _firebaseAuthService.currentUser != null;

  void navigateToHomeScreen() =>
      _navigationService.navigateBackUntil(HomeScreen.route);

  bool userIsThreadOwner(Thread thread) {
    final thisUser = _firebaseAuthService.currentUser;
    return thisUser != null
        ? thisUser.uid == thread.authorId ||
            _firebaseAuthService.currentUserIsAdmin
        : false;
  }

  bool userIsPostOwner(Post post) {
    final thisUser = _firebaseAuthService.currentUser;
    return thisUser != null ? thisUser.uid == post.authorId : false;
  }

  Future<void> updateThread(Thread thread) async => _threadService
      .updateThread(thread)
      .catchError((error) => _dialogService.showDialog(
            title: 'Updating your question failed!',
            description: "Here's what we think went wrong:\n${error.message}",
          ));

  Future<void> updatePostInThread(Thread thread, Post post) async =>
      _threadService
          .updatePostInThread(thread, post)
          .catchError((error) => _dialogService.showDialog(
                title: 'Updating your message failed!',
                description:
                    "Here's what we think went wrong:\n${error.message}",
              ));

  Future<Post> addNewPostToThread(Thread thread) async {
    final thisUser = _firebaseAuthService.currentUser;
    return thisUser != null
        ? _accountService
            .getAccount(thisUser.uid)
            .then((Account account) => _threadService.addPostToThread(
                thread,
                Post(
                    id: "",
                    authorName: account.name,
                    authorId: account.id,
                    message: "Type your message here",
                    postDate: DateTime.now())))
            .catchError((error) => Future<Post>.error(
                "Adding your message failed!\nHere's what we think went wrong:\n${error.message}"))
        : Future<Post>.error("Cannot create a post when not logged in!");
  }

  Stream<List<Post>> getUpdatedThreadSpecificPosts(Thread thread) =>
      _threadService.getUpdatedThreadSpecificPosts(thread);
}
