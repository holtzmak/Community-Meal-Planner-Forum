// import 'dart:async';
//
// import 'package:app/core/account.dart';
// import 'package:app/core/post.dart';
// import 'package:app/core/thread.dart';
// import 'package:app/service/firestore_announcement_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'firebase_database_service_test.mocks.dart';
//
// final testServiceLocator = GetIt.instance;
//
// @GenerateMocks([
//   FirebaseFirestore,
//   CollectionReference,
//   DocumentReference,
//   Query,
//   QuerySnapshot,
//   QueryDocumentSnapshot
// ])
// void main() {
//   final mockFirebaseFirestore = MockFirebaseFirestore();
//   final mockCollectionReference = MockCollectionReference();
//   final mockDocumentReference = MockDocumentReference();
//   final mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
//   final mockQuerySnapshot = MockQuerySnapshot();
//   final mockQuery = MockQuery();
//   final mockQuerySnapshotStream = StreamController<QuerySnapshot>.broadcast();
//
//   group('Firebase Database Service', () {
//     setUpAll(() async {
//       testServiceLocator
//           .registerFactory<FirebaseFirestore>(() => mockFirebaseFirestore);
//     });
//     tearDownAll(() async => mockQuerySnapshotStream.close());
//
//     test('successful add account', () async {
//       final account = Account.empty();
//       when(mockFirebaseFirestore.collection('account'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.doc(account.id))
//           .thenReturn(mockDocumentReference);
//       await FirebaseDatabaseService().addAccount(account);
//       verify(mockDocumentReference.set(account.toJson())).called(1);
//     });
//
//     test('successful update account', () async {
//       final account = Account.empty();
//       when(mockFirebaseFirestore.collection('account'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.doc(account.id))
//           .thenReturn(mockDocumentReference);
//       when(mockDocumentReference.update(account.toJson()))
//           .thenAnswer((_) => Future.value());
//       await FirebaseDatabaseService().updateAccount(account);
//       verify(mockDocumentReference.update(account.toJson())).called(1);
//     });
//
//     test('successful remove account', () async {
//       when(mockFirebaseFirestore.collection('account'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.doc("test Id"))
//           .thenReturn(mockDocumentReference);
//       when(mockDocumentReference.delete())
//           .thenAnswer((_) async => Future.value());
//       await FirebaseDatabaseService().removeAccount("test Id");
//       verify(mockDocumentReference.delete()).called(1);
//     });
//
//     test(
//         'add thread should add placeholder thread, then return successful thread',
//         () async {
//       final placeholder = Thread.empty("test Id");
//       when(mockFirebaseFirestore.collection('thread'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.add(placeholder.toJson()))
//           .thenAnswer((_) async => mockDocumentReference);
//       when(mockDocumentReference.id).thenReturn("generated Id");
//       final result = await FirebaseDatabaseService().addThread(placeholder);
//       expect(placeholder.withDocumentId("generated Id"), result);
//       verify(mockCollectionReference.add(placeholder.toJson())).called(1);
//     });
//
//     test('successful update thread', () async {
//       final thread = Thread.empty("thread Id");
//       when(mockFirebaseFirestore.collection('thread'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.doc("thread Id"))
//           .thenReturn(mockDocumentReference);
//       when(mockDocumentReference.update(thread.toJson()))
//           .thenAnswer((_) => Future.value());
//       await FirebaseDatabaseService().updateThread(thread);
//       verify(mockDocumentReference.update(thread.toJson())).called(1);
//     });
//
//     test('successful add post to thread', () async {
//       final post = Post.empty("post Id");
//       final thread = Thread.empty("thread Id");
//       when(mockFirebaseFirestore.collection('thread'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.doc("thread Id"))
//           .thenReturn(mockDocumentReference);
//       when(mockDocumentReference.collection('post'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.add(post.toJson()))
//           .thenAnswer((_) async => mockDocumentReference);
//       when(mockDocumentReference.id).thenReturn("generated Id");
//       final result =
//           await FirebaseDatabaseService().addPostToThread(thread, post);
//       expect(post.withDocumentId("generated Id"), result);
//     });
//
//     test('successful update post in thread', () async {
//       final post = Post.empty("post Id");
//       final thread = Thread.empty("thread Id");
//       when(mockFirebaseFirestore.collection('thread'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.doc("thread Id"))
//           .thenReturn(mockDocumentReference);
//       when(mockDocumentReference.collection('post'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.doc('post Id'))
//           .thenReturn(mockDocumentReference);
//       when(mockDocumentReference.update(post.toJson()))
//           .thenAnswer((_) => Future.value());
//       await FirebaseDatabaseService().updatePostInThread(thread, post);
//       verify(mockDocumentReference.update(post.toJson())).called(1);
//     });
//
//     test('successful get updated account-specific threads', () async {
//       final expectedThread = Thread.empty("thread Id");
//       final expectedJson = {
//         'title': "",
//         'topics': [],
//         'subTopics': [],
//         'authorId': "",
//         'startDate': Timestamp.fromDate(expectedThread.startDate),
//         'completionDate': null,
//         'completionPost': null,
//         'canBeRepliedTo': false
//       };
//       when(mockFirebaseFirestore.collection('thread'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.where('authorId', isEqualTo: "thread Id"))
//           .thenReturn(mockQuery);
//       when(mockQuery.snapshots())
//           .thenAnswer((_) => mockQuerySnapshotStream.stream);
//       when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
//       when(mockQueryDocumentSnapshot.id).thenReturn("thread Id");
//       when(mockQueryDocumentSnapshot.data()).thenReturn(expectedJson);
//       expectLater(
//           FirebaseDatabaseService()
//               .getUpdatedAccountSpecificThreads("thread Id"),
//           emits([expectedThread]));
//       mockQuerySnapshotStream.add(mockQuerySnapshot);
//     });
//
//     test('successful get all updated threads', () async {
//       final expectedThread = Thread.empty("thread Id");
//       final expectedJson = {
//         'title': "",
//         'topics': [],
//         'subTopics': [],
//         'authorId': "",
//         'startDate': Timestamp.fromDate(expectedThread.startDate),
//         'completionDate': null,
//         'completionPost': null,
//         'canBeRepliedTo': false
//       };
//       when(mockFirebaseFirestore.collection('thread'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.snapshots())
//           .thenAnswer((_) => mockQuerySnapshotStream.stream);
//       when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
//       when(mockQueryDocumentSnapshot.id).thenReturn("thread Id");
//       when(mockQueryDocumentSnapshot.data()).thenReturn(expectedJson);
//       expectLater(FirebaseDatabaseService().getAllUpdatedThreads(),
//           emits([expectedThread]));
//       mockQuerySnapshotStream.add(mockQuerySnapshot);
//     });
//
//     test('successful get updated thread-specific posts', () async {
//       final thread = Thread.empty("thread Id");
//       final expectedPost = Post.empty("post Id");
//       final expectedJson = {
//         'authorName': "",
//         'authorId': "",
//         'message': "",
//         'postDate': Timestamp.fromDate(expectedPost.postDate),
//       };
//       when(mockFirebaseFirestore.collection('thread'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.doc("thread Id"))
//           .thenReturn(mockDocumentReference);
//       when(mockDocumentReference.collection('post'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.orderBy('postDate'))
//           .thenReturn(mockCollectionReference);
//       when(mockCollectionReference.snapshots())
//           .thenAnswer((_) => mockQuerySnapshotStream.stream);
//       when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
//       when(mockQueryDocumentSnapshot.id).thenReturn("post Id");
//       when(mockQueryDocumentSnapshot.data()).thenReturn(expectedJson);
//       expectLater(
//           FirebaseDatabaseService().getUpdatedThreadSpecificPosts(thread),
//           emits([expectedPost]));
//       mockQuerySnapshotStream.add(mockQuerySnapshot);
//     });
//   });
// }
