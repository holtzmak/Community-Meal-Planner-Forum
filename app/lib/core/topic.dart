import 'package:app/core/utility/to_camel_case.dart';

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
  static String toDisplayString(Topic it) => it.toString().split('.').last;

  static Topic fromDisplayString(String it) =>
      TopicDeserializer.fromString('Topic.${toCamelCase(it)}');
}
