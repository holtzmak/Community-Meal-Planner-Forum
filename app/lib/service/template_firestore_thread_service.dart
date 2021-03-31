import 'package:app/core/post.dart';
import 'package:app/core/thread.dart';
import 'package:app/service/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// A service wrapping Firebase Firestore, specifically for thread services
@immutable
abstract class TemplateFirestoreThreadService {
  final String collection;
  final bool isForAnnouncements;
  final _firestore = ServiceLocator.get<FirebaseFirestore>();

  TemplateFirestoreThreadService({required this.isForAnnouncements})
      : collection = isForAnnouncements ? 'announcementThread' : 'thread';

  Future<Thread> addThread(Thread placeholder) async =>
      _firestore.collection(collection).add(placeholder.toJson()).then(
          (DocumentReference docRef) => placeholder.withDocumentId(docRef.id));

  Future<void> updateThread(Thread thread) async =>
      _firestore.collection(collection).doc(thread.id).update(thread.toJson());

  Future<Post> addPostToThread(Thread thread, Post placeholder) async =>
      _firestore
          .collection(collection)
          .doc(thread.id)
          .collection('post')
          .add(placeholder.toJson())
          .then((DocumentReference docRef) =>
              placeholder.withDocumentId(docRef.id));

  Future<void> updatePostInThread(Thread thread, Post post) async => _firestore
      .collection(collection)
      .doc(thread.id)
      .collection('post')
      .doc(post.id)
      .update(post.toJson());

  Stream<List<Thread>> getAllUpdatedThreads() => _firestore
      .collection(collection)
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) => Thread.fromJson(
              id: doc.id,
              isAnnouncement: isForAnnouncements,
              json: doc.data()!))
          .toList());

  Stream<Thread> getUpdatedSpecificThread(String id) => _firestore
      .collection(collection)
      .doc(id)
      .snapshots()
      .map((DocumentSnapshot snapshot) => Thread.fromJson(
          id: snapshot.id,
          isAnnouncement: isForAnnouncements,
          json: snapshot.data()!));

  Stream<List<Post>> getUpdatedThreadSpecificPosts(Thread thread) => _firestore
      .collection(collection)
      .doc(thread.id)
      .collection('post')
      .orderBy("postDate")
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) =>
              Post.fromJson(id: doc.id, json: doc.data()!))
          .toList());
}
