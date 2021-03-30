import 'dart:async';

import 'package:app/core/account.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/firestore_account_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firebase_auth_service_test.mocks.dart';

final testServiceLocator = GetIt.instance;

@GenerateMocks(
    [UserCredential, User, FirebaseAuth, FirestoreAccountService, Account])
void main() {
  final testName = "testName";
  final testEmail = "test@mail.com";
  final testPassword = "password";
  final testAboutMeDesc = "About me...";
  final testTitles = ["Developer", "Student", "Hungry"];
  final testUserId = "test Id";
  final mockFirestoreAccountService = MockFirestoreAccountService();
  final mockFirebaseAuth = MockFirebaseAuth();
  final mockUserCredential = MockUserCredential();
  final mockUser = MockUser();
  final mockAccount = MockAccount();
  final mockAuthStateChangesController = StreamController<User?>.broadcast();

  void setupMockFirebaseAuthCreateAccount() {
    when(mockFirebaseAuth.createUserWithEmailAndPassword(
            email: testEmail, password: testPassword))
        .thenAnswer((_) async => mockUserCredential);
    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.uid).thenReturn(testUserId);
  }

  void setupAuthStateChangesMock() {
    when(mockFirebaseAuth.authStateChanges())
        .thenAnswer((_) => mockAuthStateChangesController.stream);
    when(mockFirebaseAuth.currentUser).thenReturn(null);
    when(mockFirestoreAccountService.getAccount(testUserId))
        .thenAnswer((_) => Future.value(mockAccount));
    when(mockAccount.isAdmin).thenReturn(false);
  }

  group('Firebase Authentication Service', () {
    setUpAll(() async {
      testServiceLocator.registerLazySingleton<FirestoreAccountService>(
          () => mockFirestoreAccountService);
      testServiceLocator
          .registerLazySingleton<FirebaseAuth>(() => mockFirebaseAuth);
    });
    tearDownAll(() async => mockAuthStateChangesController.close());

    test('sign up successful calls add account', () async {
      setupAuthStateChangesMock();
      setupMockFirebaseAuthCreateAccount();
      when(mockFirestoreAccountService.addAccount(any))
          .thenAnswer((_) => Future.value()); // do nothing for test
      final authService = FirebaseAuthService();

      try {
        await authService.signUp(
            name: testName,
            titles: testTitles,
            aboutMeDescription: testAboutMeDesc,
            email: testEmail,
            password: testPassword);
      } catch (e) {
        // This test should pass
        fail(e.toString());
      }
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: testEmail, password: testPassword))
          .called(1);
      verify(mockFirestoreAccountService.addAccount(any)).called(1);
    });

    test('sign up failed, create user failed', () async {
      setupAuthStateChangesMock();
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: testEmail, password: testPassword))
          .thenAnswer((_) async => Future.error('Error Here'));
      try {
        await FirebaseAuthService().signUp(
            name: testName,
            titles: testTitles,
            aboutMeDescription: testAboutMeDesc,
            email: testEmail,
            password: testPassword);
      } catch (e) {
        expect(e, 'Error Here');
      }
    });

    test('delete account failed, not logged in', () async {
      setupAuthStateChangesMock();
      try {
        await FirebaseAuthService().deleteAccount();
      } catch (e) {
        expect(e, "You cannot delete your account if you are not logged in");
      }
    });

    test(
        'current user stream updates when current user changes, getCurrentUser updates too',
        () async {
      setupAuthStateChangesMock();
      final authService = FirebaseAuthService();

      when(mockUser.toString())
          .thenReturn("Mock User"); // As needed by emitsInOrder
      expectLater(
          authService.currentUserChanges, emitsInOrder([null, mockUser, null]));

      // Start state
      mockAuthStateChangesController.add(null);
      // Let changes propagate
      await Future.value(Duration(milliseconds: 1));

      mockAuthStateChangesController.add(mockUser);
      // Let changes propagate
      await Future.value(Duration(milliseconds: 1));
      expect(authService.currentUser, mockUser);

      mockAuthStateChangesController.add(null);
      // Let changes propagate
      await Future.value(Duration(milliseconds: 1));
      expect(authService.currentUser, null);
    });

    test('current user is admin stream updates when current user changes',
        () async {
      when(mockFirebaseAuth.authStateChanges())
          .thenAnswer((_) => mockAuthStateChangesController.stream);
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      when(mockUser.uid).thenReturn(testUserId);
      when(mockFirestoreAccountService.getAccount(testUserId))
          .thenAnswer((_) => Future.value(mockAccount));
      when(mockAccount.isAdmin).thenReturn(true);
      final authService = FirebaseAuthService();

      when(mockUser.toString())
          .thenReturn("Mock User"); // As needed by emitsInOrder
      expectLater(authService.currentUserIsAdminChanges,
          emitsInOrder([false, true, false]));

      // TODO: When we can control when the inner future getAccount completes
      // Check the state of currentUserIsAdmin between state changes
      mockAuthStateChangesController.add(null);
      mockAuthStateChangesController.add(mockUser);
      mockAuthStateChangesController.add(null);
    });
  });
}
