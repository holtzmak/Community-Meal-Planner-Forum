import 'dart:async';

import 'package:app/core/account.dart';
import 'package:app/core/administration_application.dart';
import 'package:app/core/post.dart';
import 'package:app/core/thread.dart';
import 'package:app/core/thread_flag.dart';
import 'package:app/service/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A service wrapping Firebase Firestore, specifically for the app
/// TODO: Split this service up based on types
class FirebaseDatabaseService {
  final _firestore = ServiceLocator.get<FirebaseFirestore>();

  Future<void> addAccount(Account account) async =>
      _firestore.collection('account').doc(account.id).set(account.toJson());

  Future<void> updateAccount(Account account) async =>
      _firestore.collection('account').doc(account.id).update(account.toJson());

  Future<void> removeAccount(String id) async =>
      _firestore.collection('account').doc(id).delete();

  Future<Account> getAccount(String id) => _firestore
      .collection('account')
      .doc(id)
      .get()
      .then((DocumentSnapshot snapshot) => Account.fromJson(snapshot.data()!));

  Stream<Account> getAccountUpdates(String id) => _firestore
      .collection('account')
      .doc(id)
      .snapshots()
      .map((DocumentSnapshot snapshot) => Account.fromJson(snapshot.data()!));

  Future<Thread> addThread(Thread placeholder) async =>
      _firestore.collection('thread').add(placeholder.toJson()).then(
          (DocumentReference docRef) => placeholder.withDocumentId(docRef.id));

  Future<Thread> addAnnouncementThread(Thread placeholder) async => _firestore
      .collection('announcementThread')
      .add(placeholder.toJson())
      .then(
          (DocumentReference docRef) => placeholder.withDocumentId(docRef.id));

  Future<void> updateThread(Thread thread) async =>
      _firestore.collection('thread').doc(thread.id).update(thread.toJson());

  Future<void> updateAnnouncementThread(Thread thread) async => _firestore
      .collection('announcementThread')
      .doc(thread.id)
      .update(thread.toJson());

  Future<Post> addPostToThread(Thread thread, Post placeholder) async =>
      _firestore
          .collection('thread')
          .doc(thread.id)
          .collection('post')
          .add(placeholder.toJson())
          .then((DocumentReference docRef) =>
              placeholder.withDocumentId(docRef.id));

  Future<Post> addPostToAnnouncementThread(
          Thread thread, Post placeholder) async =>
      _firestore
          .collection('announcementThread')
          .doc(thread.id)
          .collection('post')
          .add(placeholder.toJson())
          .then((DocumentReference docRef) =>
              placeholder.withDocumentId(docRef.id));

  Future<void> updatePostInThread(Thread thread, Post post) async => _firestore
      .collection('thread')
      .doc(thread.id)
      .collection('post')
      .doc(post.id)
      .update(post.toJson());

  Future<void> updatePostInAnnouncementThread(Thread thread, Post post) async =>
      _firestore
          .collection('announcementThread')
          .doc(thread.id)
          .collection('post')
          .doc(post.id)
          .update(post.toJson());

  Stream<List<Thread>> getUpdatedAccountSpecificThreads(String id) => _firestore
      .collection('thread')
      .where('authorId', isEqualTo: id)
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) =>
              Thread.fromJson(id: doc.id, json: doc.data()!))
          .toList());

  Future<Thread> getLatestAccountSpecificThread(String id) => _firestore
      .collection('thread')
      .where('authorId', isEqualTo: id)
      .orderBy("startDate")
      .limitToLast(1)
      .get()
      .then((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) =>
              Thread.fromJson(id: doc.id, json: doc.data()!))
          .first);

  Stream<List<Thread>> getUpdatedAnnouncementThreads() => _firestore
      .collection('announcementThread')
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) =>
              Thread.fromJson(id: doc.id, json: doc.data()!))
          .toList());

  Future<Thread> getLatestAnnouncementThread() => _firestore
      .collection('announcementThread')
      .orderBy("startDate")
      .limitToLast(1)
      .get()
      .then((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) =>
              Thread.fromJson(id: doc.id, json: doc.data()!))
          .first);

  Stream<List<Thread>> getAllUpdatedThreads() => _firestore
      .collection('thread')
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) =>
              Thread.fromJson(id: doc.id, json: doc.data()!))
          .toList());

  Stream<Thread> getUpdatedSpecificThread(String id) => _firestore
      .collection('thread')
      .doc(id)
      .snapshots()
      .map((DocumentSnapshot snapshot) =>
          Thread.fromJson(id: snapshot.id, json: snapshot.data()!));

  Stream<Thread> getUpdatedSpecificAnnouncementThread(String id) => _firestore
      .collection('announcementThread')
      .doc(id)
      .snapshots()
      .map((DocumentSnapshot snapshot) =>
          Thread.fromJson(id: snapshot.id, json: snapshot.data()!));

  Stream<List<Post>> getUpdatedThreadSpecificPosts(Thread thread) => _firestore
      .collection('thread')
      .doc(thread.id)
      .collection('post')
      .orderBy("postDate")
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) =>
              Post.fromJson(id: doc.id, json: doc.data()!))
          .toList());

  Stream<List<Post>> getUpdatedAnnouncementThreadSpecificPosts(Thread thread) =>
      _firestore
          .collection('announcementThread')
          .doc(thread.id)
          .collection('post')
          .orderBy("postDate")
          .snapshots()
          .map((QuerySnapshot snapshot) => snapshot.docs
              .map((QueryDocumentSnapshot doc) =>
                  Post.fromJson(id: doc.id, json: doc.data()!))
              .toList());

  Future<void> addAdminApplication(
          AdministrationApplication application) async =>
      _firestore
          .collection('adminApplication')
          .doc(application.applicantId)
          .set(application.toJson());

  Future<void> updateAdminApplication(
          AdministrationApplication application) async =>
      _firestore
          .collection('adminApplication')
          .doc(application.applicantId)
          .update(application.toJson());

  Stream<List<AdministrationApplication>> getAllUpdatedAdminApplications() =>
      _firestore.collection('adminApplication').snapshots().map(
          (QuerySnapshot snapshot) => snapshot.docs
              .map((QueryDocumentSnapshot doc) =>
                  AdministrationApplication.fromJson(
                      id: doc.id, json: doc.data()!))
              .toList());

  Future<void> addThreadFlag(ThreadFlag threadFlag) async => _firestore
      .collection('threadFlag')
      .doc(threadFlag.id)
      .set(threadFlag.toJson());

  Future<void> removeThreadFlag(String id) async =>
      _firestore.collection('threadFlag').doc(id).delete();

  Stream<List<ThreadFlag>> getAllThreadFlags() => _firestore
      .collection('threadFlag')
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) =>
              ThreadFlag.fromJson(id: doc.id, json: doc.data()!))
          .toList());
}
