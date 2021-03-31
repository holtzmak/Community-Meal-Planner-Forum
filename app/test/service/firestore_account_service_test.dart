import 'dart:async';

import 'package:app/core/account.dart';
import 'package:app/service/firestore_account_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firestore_account_service_test.mocks.dart';

final testServiceLocator = GetIt.instance;

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
])
void main() {
  final mockFirebaseFirestore = MockFirebaseFirestore();
  final mockCollectionReference = MockCollectionReference();
  final mockDocumentReference = MockDocumentReference();

  group('Firestore Account Service', () {
    setUpAll(() async {
      testServiceLocator
          .registerFactory<FirebaseFirestore>(() => mockFirebaseFirestore);
    });

    test('successful add account', () async {
      final account = Account.empty();
      when(mockFirebaseFirestore.collection('account'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(account.id))
          .thenReturn(mockDocumentReference);
      await FirestoreAccountService().addAccount(account);
      verify(mockDocumentReference.set(account.toJson())).called(1);
    });

    test('successful update account', () async {
      final account = Account.empty();
      when(mockFirebaseFirestore.collection('account'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(account.id))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.update(account.toJson()))
          .thenAnswer((_) => Future.value());
      await FirestoreAccountService().updateAccount(account);
      verify(mockDocumentReference.update(account.toJson())).called(1);
    });

    test('successful remove account', () async {
      when(mockFirebaseFirestore.collection('account'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc("test Id"))
          .thenReturn(mockDocumentReference);
      when(mockDocumentReference.delete())
          .thenAnswer((_) async => Future.value());
      await FirestoreAccountService().removeAccount("test Id");
      verify(mockDocumentReference.delete()).called(1);
    });
  });
}
