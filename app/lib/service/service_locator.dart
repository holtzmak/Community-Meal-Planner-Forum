import 'package:app/service/dialog_service.dart';
import 'package:app/service/firebase_auth_service.dart';
import 'package:app/service/firestore_account_service.dart';
import 'package:app/service/firestore_admin_service.dart';
import 'package:app/service/firestore_announcement_service.dart';
import 'package:app/service/firestore_thread_service.dart';
import 'package:app/service/navigation_service.dart';
import 'package:app/ui/view_model/about_and_legal_view_model.dart';
import 'package:app/ui/view_model/all_questions_view_model.dart';
import 'package:app/ui/view_model/announcement_view_model.dart';
import 'package:app/ui/view_model/announcements_view_model.dart';
import 'package:app/ui/view_model/application_view_model.dart';
import 'package:app/ui/view_model/applications_to_review_view_model.dart';
import 'package:app/ui/view_model/flagged_threads_view_model.dart';
import 'package:app/ui/view_model/home_view_model.dart';
import 'package:app/ui/view_model/log_in_view_model.dart';
import 'package:app/ui/view_model/my_questions_view_model.dart';
import 'package:app/ui/view_model/new_announcement_view_model.dart';
import 'package:app/ui/view_model/new_question_view_model.dart';
import 'package:app/ui/view_model/sign_up_view_model.dart';
import 'package:app/ui/view_model/thread_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final get = GetIt.instance;

  static void setup() {
    get.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    get.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);
    get.registerLazySingleton<FirestoreAccountService>(
        () => FirestoreAccountService());
    get.registerLazySingleton<FirestoreAdminService>(
        () => FirestoreAdminService());
    get.registerLazySingleton<FirestoreAnnouncementService>(
        () => FirestoreAnnouncementService());
    get.registerLazySingleton<FirestoreThreadService>(
        () => FirestoreThreadService());
    get.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
    get.registerLazySingleton<DialogService>(() => DialogService());
    get.registerLazySingleton<NavigationService>(() => NavigationService());

    get.registerFactory<SignUpViewModel>(() => SignUpViewModel());
    get.registerFactory<LogInViewModel>(() => LogInViewModel());
    get.registerFactory<HomeViewModel>(() => HomeViewModel());
    get.registerFactory<ThreadViewModel>(() => ThreadViewModel());
    get.registerFactory<AnnouncementViewModel>(() => AnnouncementViewModel());
    get.registerFactory<MyQuestionsViewModel>(() => MyQuestionsViewModel());
    get.registerFactory<AnnouncementsViewModel>(() => AnnouncementsViewModel());
    get.registerFactory<AllQuestionsViewModel>(() => AllQuestionsViewModel());
    get.registerFactory<NewAnnouncementViewModel>(
        () => NewAnnouncementViewModel());
    get.registerFactory<NewQuestionViewModel>(() => NewQuestionViewModel());
    get.registerFactory<FlaggedThreadsViewModel>(
        () => FlaggedThreadsViewModel());
    get.registerFactory<ApplicationViewModel>(() => ApplicationViewModel());
    get.registerFactory<ApplicationsToReviewViewModel>(
        () => ApplicationsToReviewViewModel());
    get.registerFactory<AboutAndLegalViewModel>(() => AboutAndLegalViewModel());
  }
}
