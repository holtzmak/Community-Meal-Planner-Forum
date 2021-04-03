import 'dart:async';

import 'package:app/core/administration_application.dart';
import 'package:app/core/thread_flag.dart';
import 'package:app/service/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A service wrapping Firebase Firestore, specifically for admin services
class FirestoreAdminService {
  final _firestore = ServiceLocator.get<FirebaseFirestore>();

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
      _firestore
          .collection('adminApplication')
          .orderBy("submissionDate")
          .snapshots()
          .map((QuerySnapshot snapshot) => snapshot.docs
              .map((QueryDocumentSnapshot doc) =>
                  AdministrationApplication.fromJson(
                      id: doc.id, json: doc.data()!))
              .toList());

  Future<void> addThreadFlag(ThreadFlag threadFlag) async =>
      _firestore.collection('threadFlag').add(threadFlag.toJson());

  Future<void> removeThreadFlag(String id) async =>
      _firestore.collection('threadFlag').doc(id).delete();

  Stream<List<ThreadFlag>> getAllUpdatedThreadFlags() => _firestore
      .collection('threadFlag')
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.docs
          .map((QueryDocumentSnapshot doc) =>
              ThreadFlag.fromJson(id: doc.id, json: doc.data()!))
          .toList());
}
