import 'dart:async';

import 'package:app/core/thread.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/service/template_firestore_thread_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A service wrapping Firebase Firestore, specifically for announcement services
class FirestoreAnnouncementService extends TemplateFirestoreThreadService {
  final _firestore = ServiceLocator.get<FirebaseFirestore>();

  FirestoreAnnouncementService() : super(isForAnnouncements: true);

  Future<Thread> getLatestAnnouncementThread() => _firestore
      .collection('announcementThread')
      .orderBy("startDate")
      .limitToLast(1)
      .get()
      .then((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) => Thread.fromJson(
              id: doc.id, isAnnouncement: true, json: doc.data()))
          .first);
}
