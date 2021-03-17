import 'package:app/core/utility/to_camel_case.dart';

enum SubTopic { critique, praise, generalDiscussion, suggestions, undefined }

/// Particularly used for JSON conversion
extension SubTopicDeserializer on SubTopic {
  static SubTopic fromString(String it) {
    for (SubTopic subTopic in SubTopic.values) {
      if (subTopic.toString() == it) {
        return subTopic;
      }
    }
    return SubTopic.undefined;
  }
}

extension SubTopicString on SubTopic {
  static String toDisplayString(SubTopic it) => it.toString().split('.').last;

  static SubTopic fromDisplayString(String it) =>
      SubTopicDeserializer.fromString('SubTopic.${toCamelCase(it)}');
}
