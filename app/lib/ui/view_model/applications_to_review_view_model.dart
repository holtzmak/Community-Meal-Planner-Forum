import 'dart:async';

import 'package:app/core/administration_application.dart';
import 'package:app/service/firestore_admin_service.dart';
import 'package:app/service/service_locator.dart';
import 'package:app/ui/view_model/specific_item_view_model.dart';
import 'package:flutter/foundation.dart';

class ApplicationsToReviewViewModel
    extends SpecificItemViewModel<AdministrationApplication> {
  final _adminService = ServiceLocator.get<FirestoreAdminService>();
  StreamSubscription<List<AdministrationApplication>>?
      _applicationsSubscription;

  @mustCallSuper
  void dispose() {
    removeAll();
    if (_applicationsSubscription != null) _applicationsSubscription!.cancel();
    super.dispose();
  }

  ApplicationsToReviewViewModel() {
    _applicationsSubscription = _adminService
        .getAllUpdatedAdminApplications()
        .listen((List<AdministrationApplication> applications) {
      removeAll();
      addAll(applications);
    });
  }
}
