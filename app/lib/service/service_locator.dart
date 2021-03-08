import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/firebase_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final it = GetIt.instance;

  static void setup() {
    it.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    it.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);
    it.registerLazySingleton<FirebaseDatabaseService>(
        () => FirebaseDatabaseService());
    it.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  }
}
