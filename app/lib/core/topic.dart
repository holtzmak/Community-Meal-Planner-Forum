import 'package:recase/recase.dart';

enum Topic {
  sustainablePractices,
  tools,
  recipes,
  generalPractices,
  education,
  undefined
}

/// Particularly used for JSON conversion
extension TopicDeserializer on Topic {
  static Topic fromString(String it) {
    for (Topic topic in Topic.values) {
      if (topic.toString() == it) {
        return topic;
      }
    }
    return Topic.undefined;
  }
}

extension TopicString on Topic {
  static String toDisplayString(Topic it) =>
      ReCase(it.toString().split('.').last).sentenceCase;

  static Topic fromDisplayString(String it) =>
      TopicDeserializer.fromString('Topic.${ReCase(it).camelCase}');
}
