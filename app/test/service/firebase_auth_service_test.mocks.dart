// Mocks generated by Mockito 5.0.0 from annotations
// in app/test/service/firebase_auth_service_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i10;

import 'package:app/core/account.dart' as _i17;
import 'package:app/core/post.dart' as _i8;
import 'package:app/core/thread.dart' as _i7;
import 'package:app/service/firebase_database_service.dart' as _i16;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_auth_platform_interface/src/action_code_info.dart'
    as _i6;
import 'package:firebase_auth_platform_interface/src/action_code_settings.dart'
    as _i12;
import 'package:firebase_auth_platform_interface/src/auth_credential.dart'
    as _i11;
import 'package:firebase_auth_platform_interface/src/auth_provider.dart'
    as _i15;
import 'package:firebase_auth_platform_interface/src/id_token_result.dart'
    as _i3;
import 'package:firebase_auth_platform_interface/src/providers/phone_auth.dart'
    as _i13;
import 'package:firebase_auth_platform_interface/src/types.dart' as _i14;
import 'package:firebase_auth_platform_interface/src/user_info.dart' as _i9;
import 'package:firebase_auth_platform_interface/src/user_metadata.dart' as _i2;
import 'package:firebase_core/firebase_core.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeUserMetadata extends _i1.Fake implements _i2.UserMetadata {}

class _FakeIdTokenResult extends _i1.Fake implements _i3.IdTokenResult {}

class _FakeUserCredential extends _i1.Fake implements _i4.UserCredential {}

class _FakeConfirmationResult extends _i1.Fake
    implements _i4.ConfirmationResult {}

class _FakeUser extends _i1.Fake implements _i4.User {}

class _FakeFirebaseApp extends _i1.Fake implements _i5.FirebaseApp {}

class _FakeActionCodeInfo extends _i1.Fake implements _i6.ActionCodeInfo {}

class _FakeThread extends _i1.Fake implements _i7.Thread {}

class _FakePost extends _i1.Fake implements _i8.Post {}

/// A class which mocks [UserCredential].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserCredential extends _i1.Mock implements _i4.UserCredential {
  MockUserCredential() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String toString() =>
      (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '')
          as String);
}

/// A class which mocks [User].
///
/// See the documentation for Mockito's code generation for more information.
class MockUser extends _i1.Mock implements _i4.User {
  MockUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get emailVerified =>
      (super.noSuchMethod(Invocation.getter(#emailVerified), returnValue: false)
          as bool);
  @override
  bool get isAnonymous =>
      (super.noSuchMethod(Invocation.getter(#isAnonymous), returnValue: false)
          as bool);
  @override
  _i2.UserMetadata get metadata =>
      (super.noSuchMethod(Invocation.getter(#metadata),
          returnValue: _FakeUserMetadata()) as _i2.UserMetadata);
  @override
  List<_i9.UserInfo> get providerData =>
      (super.noSuchMethod(Invocation.getter(#providerData),
          returnValue: <_i9.UserInfo>[]) as List<_i9.UserInfo>);
  @override
  String get uid =>
      (super.noSuchMethod(Invocation.getter(#uid), returnValue: '') as String);
  @override
  _i10.Future<void> delete() =>
      (super.noSuchMethod(Invocation.method(#delete, []),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<String> getIdToken([bool? forceRefresh = false]) =>
      (super.noSuchMethod(Invocation.method(#getIdToken, [forceRefresh]),
          returnValue: Future.value('')) as _i10.Future<String>);
  @override
  _i10.Future<_i3.IdTokenResult> getIdTokenResult(
          [bool? forceRefresh = false]) =>
      (super.noSuchMethod(Invocation.method(#getIdTokenResult, [forceRefresh]),
              returnValue: Future.value(_FakeIdTokenResult()))
          as _i10.Future<_i3.IdTokenResult>);
  @override
  _i10.Future<_i4.UserCredential> linkWithCredential(
          _i11.AuthCredential? credential) =>
      (super.noSuchMethod(Invocation.method(#linkWithCredential, [credential]),
              returnValue: Future.value(_FakeUserCredential()))
          as _i10.Future<_i4.UserCredential>);
  @override
  _i10.Future<_i4.ConfirmationResult> linkWithPhoneNumber(String? phoneNumber,
          [_i4.RecaptchaVerifier? verifier]) =>
      (super.noSuchMethod(
              Invocation.method(#linkWithPhoneNumber, [phoneNumber, verifier]),
              returnValue: Future.value(_FakeConfirmationResult()))
          as _i10.Future<_i4.ConfirmationResult>);
  @override
  _i10.Future<_i4.UserCredential> reauthenticateWithCredential(
          _i11.AuthCredential? credential) =>
      (super.noSuchMethod(
              Invocation.method(#reauthenticateWithCredential, [credential]),
              returnValue: Future.value(_FakeUserCredential()))
          as _i10.Future<_i4.UserCredential>);
  @override
  _i10.Future<void> reload() =>
      (super.noSuchMethod(Invocation.method(#reload, []),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> sendEmailVerification(
          [_i12.ActionCodeSettings? actionCodeSettings]) =>
      (super.noSuchMethod(
          Invocation.method(#sendEmailVerification, [actionCodeSettings]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<_i4.User> unlink(String? providerId) =>
      (super.noSuchMethod(Invocation.method(#unlink, [providerId]),
          returnValue: Future.value(_FakeUser())) as _i10.Future<_i4.User>);
  @override
  _i10.Future<void> updateEmail(String? newEmail) =>
      (super.noSuchMethod(Invocation.method(#updateEmail, [newEmail]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> updatePassword(String? newPassword) =>
      (super.noSuchMethod(Invocation.method(#updatePassword, [newPassword]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> updatePhoneNumber(
          _i13.PhoneAuthCredential? phoneCredential) =>
      (super.noSuchMethod(
          Invocation.method(#updatePhoneNumber, [phoneCredential]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> updateProfile({String? displayName, String? photoURL}) =>
      (super.noSuchMethod(
          Invocation.method(#updateProfile, [],
              {#displayName: displayName, #photoURL: photoURL}),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> verifyBeforeUpdateEmail(String? newEmail,
          [_i12.ActionCodeSettings? actionCodeSettings]) =>
      (super.noSuchMethod(
          Invocation.method(
              #verifyBeforeUpdateEmail, [newEmail, actionCodeSettings]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  String toString() =>
      (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '')
          as String);
}

/// A class which mocks [FirebaseAuth].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseAuth extends _i1.Mock implements _i4.FirebaseAuth {
  MockFirebaseAuth() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.FirebaseApp get app => (super.noSuchMethod(Invocation.getter(#app),
      returnValue: _FakeFirebaseApp()) as _i5.FirebaseApp);
  @override
  set app(_i5.FirebaseApp? _app) =>
      super.noSuchMethod(Invocation.setter(#app, _app),
          returnValueForMissingStub: null);
  @override
  Map<dynamic, dynamic> get pluginConstants =>
      (super.noSuchMethod(Invocation.getter(#pluginConstants),
          returnValue: <dynamic, dynamic>{}) as Map<dynamic, dynamic>);
  @override
  _i10.Future<void> useEmulator(String? origin) =>
      (super.noSuchMethod(Invocation.method(#useEmulator, [origin]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> applyActionCode(String? code) =>
      (super.noSuchMethod(Invocation.method(#applyActionCode, [code]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<_i6.ActionCodeInfo> checkActionCode(String? code) =>
      (super.noSuchMethod(Invocation.method(#checkActionCode, [code]),
              returnValue: Future.value(_FakeActionCodeInfo()))
          as _i10.Future<_i6.ActionCodeInfo>);
  @override
  _i10.Future<void> confirmPasswordReset({String? code, String? newPassword}) =>
      (super.noSuchMethod(
          Invocation.method(#confirmPasswordReset, [],
              {#code: code, #newPassword: newPassword}),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<_i4.UserCredential> createUserWithEmailAndPassword(
          {String? email, String? password}) =>
      (super.noSuchMethod(
              Invocation.method(#createUserWithEmailAndPassword, [],
                  {#email: email, #password: password}),
              returnValue: Future.value(_FakeUserCredential()))
          as _i10.Future<_i4.UserCredential>);
  @override
  _i10.Future<List<String>> fetchSignInMethodsForEmail(String? email) => (super
      .noSuchMethod(Invocation.method(#fetchSignInMethodsForEmail, [email]),
          returnValue: Future.value(<String>[])) as _i10.Future<List<String>>);
  @override
  _i10.Future<_i4.UserCredential> getRedirectResult() =>
      (super.noSuchMethod(Invocation.method(#getRedirectResult, []),
              returnValue: Future.value(_FakeUserCredential()))
          as _i10.Future<_i4.UserCredential>);
  @override
  bool isSignInWithEmailLink(String? emailLink) => (super.noSuchMethod(
      Invocation.method(#isSignInWithEmailLink, [emailLink]),
      returnValue: false) as bool);
  @override
  _i10.Stream<_i4.User?> authStateChanges() =>
      (super.noSuchMethod(Invocation.method(#authStateChanges, []),
          returnValue: Stream<_i4.User?>.empty()) as _i10.Stream<_i4.User?>);
  @override
  _i10.Stream<_i4.User?> idTokenChanges() =>
      (super.noSuchMethod(Invocation.method(#idTokenChanges, []),
          returnValue: Stream<_i4.User?>.empty()) as _i10.Stream<_i4.User?>);
  @override
  _i10.Stream<_i4.User?> userChanges() =>
      (super.noSuchMethod(Invocation.method(#userChanges, []),
          returnValue: Stream<_i4.User?>.empty()) as _i10.Stream<_i4.User?>);
  @override
  _i10.Future<void> sendPasswordResetEmail(
          {String? email, _i12.ActionCodeSettings? actionCodeSettings}) =>
      (super.noSuchMethod(
          Invocation.method(#sendPasswordResetEmail, [],
              {#email: email, #actionCodeSettings: actionCodeSettings}),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> sendSignInLinkToEmail(
          {String? email, _i12.ActionCodeSettings? actionCodeSettings}) =>
      (super.noSuchMethod(
          Invocation.method(#sendSignInLinkToEmail, [],
              {#email: email, #actionCodeSettings: actionCodeSettings}),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> setLanguageCode(String? languageCode) =>
      (super.noSuchMethod(Invocation.method(#setLanguageCode, [languageCode]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> setSettings(
          {bool? appVerificationDisabledForTesting, String? userAccessGroup}) =>
      (super.noSuchMethod(
          Invocation.method(#setSettings, [], {
            #appVerificationDisabledForTesting:
                appVerificationDisabledForTesting,
            #userAccessGroup: userAccessGroup
          }),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> setPersistence(_i14.Persistence? persistence) =>
      (super.noSuchMethod(Invocation.method(#setPersistence, [persistence]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<_i4.UserCredential> signInAnonymously() =>
      (super.noSuchMethod(Invocation.method(#signInAnonymously, []),
              returnValue: Future.value(_FakeUserCredential()))
          as _i10.Future<_i4.UserCredential>);
  @override
  _i10.Future<_i4.UserCredential> signInWithCredential(
          _i11.AuthCredential? credential) =>
      (super.noSuchMethod(
              Invocation.method(#signInWithCredential, [credential]),
              returnValue: Future.value(_FakeUserCredential()))
          as _i10.Future<_i4.UserCredential>);
  @override
  _i10.Future<_i4.UserCredential> signInWithCustomToken(String? token) =>
      (super.noSuchMethod(Invocation.method(#signInWithCustomToken, [token]),
              returnValue: Future.value(_FakeUserCredential()))
          as _i10.Future<_i4.UserCredential>);
  @override
  _i10.Future<_i4.UserCredential> signInWithEmailAndPassword(
          {String? email, String? password}) =>
      (super.noSuchMethod(
              Invocation.method(#signInWithEmailAndPassword, [],
                  {#email: email, #password: password}),
              returnValue: Future.value(_FakeUserCredential()))
          as _i10.Future<_i4.UserCredential>);
  @override
  _i10.Future<_i4.UserCredential> signInWithEmailLink(
          {String? email, String? emailLink}) =>
      (super.noSuchMethod(
              Invocation.method(#signInWithEmailLink, [],
                  {#email: email, #emailLink: emailLink}),
              returnValue: Future.value(_FakeUserCredential()))
          as _i10.Future<_i4.UserCredential>);
  @override
  _i10.Future<_i4.ConfirmationResult> signInWithPhoneNumber(String? phoneNumber,
          [_i4.RecaptchaVerifier? verifier]) =>
      (super.noSuchMethod(
          Invocation.method(#signInWithPhoneNumber, [phoneNumber, verifier]),
          returnValue:
              Future.value(_FakeConfirmationResult())) as _i10
          .Future<_i4.ConfirmationResult>);
  @override
  _i10.Future<_i4.UserCredential> signInWithPopup(
          _i15.AuthProvider? provider) =>
      (super.noSuchMethod(Invocation.method(#signInWithPopup, [provider]),
              returnValue: Future.value(_FakeUserCredential()))
          as _i10.Future<_i4.UserCredential>);
  @override
  _i10.Future<void> signInWithRedirect(_i15.AuthProvider? provider) =>
      (super.noSuchMethod(Invocation.method(#signInWithRedirect, [provider]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> signOut() =>
      (super.noSuchMethod(Invocation.method(#signOut, []),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<String> verifyPasswordResetCode(String? code) =>
      (super.noSuchMethod(Invocation.method(#verifyPasswordResetCode, [code]),
          returnValue: Future.value('')) as _i10.Future<String>);
  @override
  _i10.Future<void> verifyPhoneNumber(
          {String? phoneNumber,
          _i14.PhoneVerificationCompleted? verificationCompleted,
          _i14.PhoneVerificationFailed? verificationFailed,
          _i14.PhoneCodeSent? codeSent,
          _i14.PhoneCodeAutoRetrievalTimeout? codeAutoRetrievalTimeout,
          String? autoRetrievedSmsCodeForTesting,
          Duration? timeout = const Duration(seconds: 30),
          int? forceResendingToken}) =>
      (super.noSuchMethod(
          Invocation.method(#verifyPhoneNumber, [], {
            #phoneNumber: phoneNumber,
            #verificationCompleted: verificationCompleted,
            #verificationFailed: verificationFailed,
            #codeSent: codeSent,
            #codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
            #autoRetrievedSmsCodeForTesting: autoRetrievedSmsCodeForTesting,
            #timeout: timeout,
            #forceResendingToken: forceResendingToken
          }),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  String toString() =>
      (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '')
          as String);
}

/// A class which mocks [FirebaseDatabaseService].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseDatabaseService extends _i1.Mock
    implements _i16.FirebaseDatabaseService {
  MockFirebaseDatabaseService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<void> addAccount(_i17.Account? account) =>
      (super.noSuchMethod(Invocation.method(#addAccount, [account]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> updateAccount(_i17.Account? account) =>
      (super.noSuchMethod(Invocation.method(#updateAccount, [account]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<void> removeAccount(String? id) =>
      (super.noSuchMethod(Invocation.method(#removeAccount, [id]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<_i7.Thread> addThread(_i7.Thread? placeholder) =>
      (super.noSuchMethod(Invocation.method(#addThread, [placeholder]),
          returnValue: Future.value(_FakeThread())) as _i10.Future<_i7.Thread>);
  @override
  _i10.Future<void> updateThread(_i7.Thread? thread) =>
      (super.noSuchMethod(Invocation.method(#updateThread, [thread]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Future<_i8.Post> addPostToThread(
          _i7.Thread? thread, _i8.Post? placeholder) =>
      (super.noSuchMethod(
          Invocation.method(#addPostToThread, [thread, placeholder]),
          returnValue: Future.value(_FakePost())) as _i10.Future<_i8.Post>);
  @override
  _i10.Future<void> updatePostInThread(_i7.Thread? thread, _i8.Post? post) =>
      (super.noSuchMethod(
          Invocation.method(#updatePostInThread, [thread, post]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i10.Future<void>);
  @override
  _i10.Stream<List<_i7.Thread>> getUpdatedAccountSpecificThreads(String? id) =>
      (super.noSuchMethod(
              Invocation.method(#getUpdatedAccountSpecificThreads, [id]),
              returnValue: Stream<List<_i7.Thread>>.empty())
          as _i10.Stream<List<_i7.Thread>>);
  @override
  _i10.Stream<List<_i7.Thread>> getAllUpdatedThreads() =>
      (super.noSuchMethod(Invocation.method(#getAllUpdatedThreads, []),
              returnValue: Stream<List<_i7.Thread>>.empty())
          as _i10.Stream<List<_i7.Thread>>);
  @override
  _i10.Stream<List<_i8.Post>> getUpdatedThreadSpecificPosts(
          _i7.Thread? thread) =>
      (super.noSuchMethod(
              Invocation.method(#getUpdatedThreadSpecificPosts, [thread]),
              returnValue: Stream<List<_i8.Post>>.empty())
          as _i10.Stream<List<_i8.Post>>);
}