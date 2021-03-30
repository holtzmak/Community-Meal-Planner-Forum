import 'package:app/core/approval_status.dart';
import 'package:flutter/foundation.dart';

@immutable
class AdministrationApplication {
  final String applicantName;
  final String applicantId; // Also the Firebase Firestore ID
  final DateTime submissionDate;
  final ApprovalStatus approvalStatus;

  AdministrationApplication(
      {required this.applicantName,
      required this.applicantId,
      required this.submissionDate,
      required this.approvalStatus});

  AdministrationApplication.empty(String id)
      : applicantName = "",
        applicantId = "",
        submissionDate = DateTime.now(),
        approvalStatus = ApprovalStatus.nothing;

  AdministrationApplication.fromJson(
      {required String id, required Map<String, dynamic> json})
      : applicantName = json['applicantName'],
        applicantId = id,
        submissionDate = json['submissionDate'].toDate(),
        approvalStatus =
            ApprovalStatusDeserializer.fromString(json['approvalStatus']);

  Map<String, dynamic> toJson() => {
        'applicantName': applicantName,
        'applicantId': applicantId,
        'submissionDate': submissionDate,
        'approvalStatus': approvalStatus.toString()
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdministrationApplication &&
          runtimeType == other.runtimeType &&
          applicantName == other.applicantName &&
          applicantId == other.applicantId &&
          submissionDate == other.submissionDate &&
          approvalStatus == other.approvalStatus;

  @override
  int get hashCode =>
      applicantName.hashCode ^
      applicantId.hashCode ^
      submissionDate.hashCode ^
      approvalStatus.hashCode;

  @override
  String toString() {
    return 'AdministrationApplication{applicantName: $applicantName, applicantId: $applicantId, submissionDate: $submissionDate, approvalStatus: $approvalStatus}';
  }

  AdministrationApplication withApprovalStatus(ApprovalStatus newStatus) =>
      AdministrationApplication(
          applicantName: applicantName,
          applicantId: applicantId,
          submissionDate: submissionDate,
          approvalStatus: newStatus);
}
