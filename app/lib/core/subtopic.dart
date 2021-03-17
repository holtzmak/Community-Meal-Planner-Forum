import 'package:recase/recase.dart';

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
  static String toDisplayString(SubTopic it) =>
      ReCase(it.toString().split('.').last).sentenceCase;

  static SubTopic fromDisplayString(String it) =>
      SubTopicDeserializer.fromString('SubTopic.${ReCase(it).camelCase}');
}
