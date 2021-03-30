import 'package:recase/recase.dart';

enum ApprovalStatus { approved, denied, nothing, undefined }

/// Particularly used for JSON conversion
extension ApprovalStatusDeserializer on ApprovalStatus {
  static ApprovalStatus fromString(String it) {
    for (ApprovalStatus subTopic in ApprovalStatus.values) {
      if (subTopic.toString() == it) {
        return subTopic;
      }
    }
    return ApprovalStatus.undefined;
  }
}

extension ApprovalStatusString on ApprovalStatus {
  static String toDisplayString(ApprovalStatus it) =>
      ReCase(it.toString().split('.').last).sentenceCase;

  static ApprovalStatus fromDisplayString(String it) =>
      ApprovalStatusDeserializer.fromString(
          'ApprovalStatus.${ReCase(it).camelCase}');
}
