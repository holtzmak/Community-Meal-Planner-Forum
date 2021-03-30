import 'package:recase/recase.dart';

enum FlagReason {
  unsure,
  incorrectInformation,
  incorrectLabel,
  policyViolation,
  undefined
}

/// Particularly used for JSON conversion
extension FlagReasonDeserializer on FlagReason {
  static FlagReason fromString(String it) {
    for (FlagReason subTopic in FlagReason.values) {
      if (subTopic.toString() == it) {
        return subTopic;
      }
    }
    return FlagReason.undefined;
  }
}

extension FlagReasonString on FlagReason {
  static String toDisplayString(FlagReason it) =>
      ReCase(it.toString().split('.').last).sentenceCase;

  static FlagReason fromDisplayString(String it) =>
      FlagReasonDeserializer.fromString(
          'ApprovalStatus.${ReCase(it).camelCase}');
}
