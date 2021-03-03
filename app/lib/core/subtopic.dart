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
