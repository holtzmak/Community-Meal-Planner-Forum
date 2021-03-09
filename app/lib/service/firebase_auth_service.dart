import 'dart:async';

import 'package:app/core/account.dart';
import 'package:app/service/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_database_service.dart';

/// A service wrapping FirebaseAuth
/// Sign in persistence is guaranteed default as per https://firebase.flutter.dev/docs/auth/usage/#persisting-authentication-state
class FirebaseAuthService {
  final _databaseService = ServiceLocator.get<FirebaseDatabaseService>();
  final _firebaseAuth = ServiceLocator.get<FirebaseAuth>();

  late StreamSubscription<User?> _authStateChanges;

  // The current user information is the same as the Account information
  // but separate for Firebase Authentication
  late User? _currentUser;

  User? get currentUser => _currentUser;

  late Stream<User?> currentUserChanges;

  // Also not truly disposed of. See above comment.
  final StreamController<User?> _currentUserChangesStream =
      StreamController<User?>.broadcast();

  // Not disposed of in destructor because FirebaseAuthService goes out of scope
  // when app is destroyed. The disposal is handled by garbage cleanup. Also,
  // Dart does not define destructors https://github.com/dart-lang/sdk/issues/3691
  void dispose() async {
    _currentUserChangesStream.close();
    _authStateChanges.cancel();
  }

  FirebaseAuthService() {
    _currentUser = _firebaseAuth.currentUser;
    currentUserChanges = _currentUserChangesStream.stream;
    _authStateChanges =
        _firebaseAuth.authStateChanges().listen((User? userMaybe) async {
      _currentUser = userMaybe;
      _currentUserChangesStream.add(userMaybe);
    });
  }

  Future<void> signOut() async => _firebaseAuth.signOut();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async =>
      _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

  Future<void> signUp({
    required String name,
    required List<String> titles,
    required String aboutMeDescription,
    required String email,
    required String password,
  }) async =>
      _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((UserCredential userCredential) => _databaseService.addAccount(
              Account(
                  id: userCredential.user!.uid,
                  name: name,
                  titles: titles,
                  aboutMeDescription: aboutMeDescription,
                  joinDate: DateTime.now())));

  Future<void> deleteAccount() async => _currentUser != null
      ? _databaseService
          .removeAccount(_currentUser!.uid)
          .then((_) => _firebaseAuth.currentUser!.delete())
      : Future.error("You cannot delete your account if you are not logged in");
}
