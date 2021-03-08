import 'dart:async';

import 'package:app/core/account.dart';
import 'package:app/core/post.dart';
import 'package:app/core/thread.dart';
import 'package:app/service/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabaseService {
  final _firestore = ServiceLocator.it<FirebaseFirestore>();

  Future<void> addAccount(Account account) async =>
      _firestore.collection('account').doc(account.id).set(account.toJson());

  Future<void> updateAccount(Account account) async =>
      _firestore.collection('account').doc(account.id).update(account.toJson());

  Future<void> removeAccount(String id) async =>
      _firestore.collection('account').doc(id).delete();

  Future<Thread> addThread(Thread placeholder) async => _firestore
      .collection('thread')
      .add(placeholder.toJson())
      .then((docRef) => placeholder.withDocumentId(docRef.id));

  Future<void> updateThread(Thread thread) async =>
      _firestore.collection('thread').doc(thread.id).update(thread.toJson());

  Future<Post> addPostToThread(Thread thread, Post placeholder) async =>
      _firestore
          .collection('thread')
          .doc(thread.id)
          .collection('post')
          .add(placeholder.toJson())
          .then((docRef) => placeholder.withDocumentId(docRef.id));

  Future<void> updatePostInThread(Thread thread, Post post) async => _firestore
      .collection('thread')
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

  Stream<List<Thread>> getAllUpdatedThreads() => _firestore
      .collection('thread')
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) =>
              Thread.fromJson(id: doc.id, json: doc.data()!))
          .toList());

  Stream<List<Post>> getUpdatedThreadSpecificPosts(Thread thread) => _firestore
      .collection('thread')
      .doc(thread.id)
      .collection('post')
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) =>
              Post.fromJson(id: doc.id, json: doc.data()!))
          .toList());
}
