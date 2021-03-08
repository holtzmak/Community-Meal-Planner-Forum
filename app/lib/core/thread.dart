import 'package:app/core/post.dart';
import 'package:app/core/subtopic.dart';
import 'package:app/core/topic.dart';
import 'package:app/core/utility/nullable_json_converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

@immutable
class Thread {
  final String id; // Firebase Firestore ID
  final String title;
  final List<Topic> topics;
  final List<SubTopic> subTopics;
  final String authorId;
  final DateTime startDate;
  final DateTime? completionDate;
  final Post? completionPost;
  final bool canBeRepliedTo;

  Thread(
      {required this.id,
      required this.title,
      required this.topics,
      required this.subTopics,
      required this.authorId,
      required this.startDate,
      required this.completionDate,
      required this.completionPost,
      required this.canBeRepliedTo});

  Thread.empty(String id)
      : id = id,
        title = "",
        topics = [],
        subTopics = [],
        authorId = "",
        startDate = DateTime.now(),
        completionDate = null,
        completionPost = null,
        canBeRepliedTo = false;

  Thread.fromJson({required String id, required Map<String, dynamic> json})
      : id = id,
        title = json['title'],
        topics = json['topics']
            .map<Topic>((topic) => TopicDeserializer.fromString(topic))
            .toList(),
        subTopics = json['subTopics']
            .map<SubTopic>(
                (subTopic) => SubTopicDeserializer.fromString(subTopic))
            .toList(),
        authorId = json['authorId'],
        startDate = json['startDate'].toDate(),
        completionDate = NullableJsonConverter().getFromJsonMaybe(
            json: json['completionDate'], transform: (it) => it.toDate()),
        completionPost = NullableJsonConverter().getFromJsonMaybe(
            json: json['completionPost'],
            transform: (it) => Post.fromJson(json: it)),
        canBeRepliedTo = json['canBeRepliedTo'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'topics': topics.map((it) => it.toString()).toList(),
        'subTopics': subTopics.map((it) => it.toString()).toList(),
        'authorId': authorId,
        'startDate': startDate,
        'completionDate': completionDate,
        'completionPost': completionPost?.toJson(),
        'canBeRepliedTo': canBeRepliedTo
      };

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      topics.hashCode ^
      subTopics.hashCode ^
      authorId.hashCode ^
      startDate.hashCode ^
      completionDate.hashCode ^
      completionPost.hashCode ^
      canBeRepliedTo.hashCode;

  @override
  bool operator ==(other) {
    return (other is Thread) &&
        other.id == id &&
        other.title == title &&
        listEquals(other.topics, topics) &&
        listEquals(other.subTopics, subTopics) &&
        other.authorId == authorId &&
        other.startDate == startDate &&
        other.completionDate == completionDate &&
        other.completionPost == completionPost &&
        other.canBeRepliedTo == canBeRepliedTo;
  }

  String toString() =>
      'Thread(id: $id, title: $title, topics: $topics, subTopics: $subTopics, authorId: $authorId, startDate: $startDate, completionDate: $completionDate, completionPost: $completionPost, canBeRepliedTo: $canBeRepliedTo)';

  Thread withDocumentId(String newId) {
    if (completionDate == null) {
      throw Exception("Cannot add topics to a completed Thread");
    }
    return Thread(
        id: newId,
        title: title,
        topics: topics,
        subTopics: subTopics,
        authorId: authorId,
        startDate: startDate,
        completionDate: completionDate,
        completionPost: completionPost,
        canBeRepliedTo: canBeRepliedTo);
  }

  Thread withTopics(List<Topic> newTopics) {
    if (completionDate == null) {
      throw Exception("Cannot add topics to a completed Thread");
    }
    return Thread(
        id: id,
        title: title,
        topics: newTopics,
        subTopics: subTopics,
        authorId: authorId,
        startDate: startDate,
        completionDate: completionDate,
        completionPost: completionPost,
        canBeRepliedTo: canBeRepliedTo);
  }

  Thread withSubTopics(List<SubTopic> newSubTopics) {
    if (completionDate == null) {
      throw Exception("Cannot add sub topics to a completed Thread");
    }
    return Thread(
        id: id,
        title: title,
        topics: topics,
        subTopics: newSubTopics,
        authorId: authorId,
        startDate: startDate,
        completionDate: completionDate,
        completionPost: completionPost,
        canBeRepliedTo: canBeRepliedTo);
  }

  Thread asCompleted(
          {required DateTime newCompletionDate,
          required Post? newCompletionPost}) =>
      Thread(
          id: id,
          title: title,
          topics: topics,
          subTopics: subTopics,
          authorId: authorId,
          startDate: startDate,
          completionDate: newCompletionDate,
          completionPost: newCompletionPost,
          canBeRepliedTo: false);

  Thread restoredAsIncomplete({required bool canBeRepliedTo}) => Thread(
      id: id,
      title: title,
      topics: topics,
      subTopics: subTopics,
      authorId: authorId,
      startDate: startDate,
      completionDate: null,
      completionPost: null,
      canBeRepliedTo: canBeRepliedTo);
}
