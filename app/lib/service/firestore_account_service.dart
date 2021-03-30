import 'package:app/core/account.dart';
import 'package:app/service/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A service wrapping Firebase Firestore, specifically for account services
class FirestoreAccountService {
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
}
