import 'dart:async';

import 'package:app/core/thread.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/service/template_firestore_thread_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A service wrapping Firebase Firestore, specifically for thread services
class FirestoreThreadService extends TemplateFirestoreThreadService {
  final _firestore = ServiceLocator.get<FirebaseFirestore>();

  FirestoreThreadService() : super(isForAnnouncements: false);

  Stream<List<Thread>> getUpdatedAccountSpecificThreads(String id) => _firestore
      .collection('thread')
      .where('authorId', isEqualTo: id)
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) => Thread.fromJson(
              id: doc.id, isAnnouncement: false, json: doc.data()!))
          .toList());

  Future<Thread> getLatestAccountSpecificThread(String id) => _firestore
      .collection('thread')
      .where('authorId', isEqualTo: id)
      .orderBy("startDate")
      .limitToLast(1)
      .get()
      .then((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) => Thread.fromJson(
              id: doc.id, isAnnouncement: false, json: doc.data()!))
          .first);
}
