import 'package:app/core/post.dart';
import 'package:app/core/subtopic.dart';
import 'package:app/core/topic.dart';
import 'package:app/core/utility/nullable_json_converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

@immutable
class Thread {
  final String title;
  final List<Topic> topics;
  final List<SubTopic> subTopics;
  final String authorUsername;
  final DateTime startDate;
  final DateTime? completionDate;
  final Post? completionPost;
  final List<Post> posts;
  final bool canBeRepliedTo;

  Thread(
      {required this.title,
      required this.topics,
      required this.subTopics,
      required this.authorUsername,
      required this.startDate,
      required this.completionDate,
      required this.completionPost,
      required this.posts,
      required this.canBeRepliedTo});

  Thread.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        topics = json['topics']
            .map<Topic>((topic) => TopicDeserializer.fromString(topic))
            .toList(),
        subTopics = json['subTopics']
            .map<SubTopic>(
                (subTopic) => SubTopicDeserializer.fromString(subTopic))
            .toList(),
        authorUsername = json['authorUsername'],
        startDate = json['startDate'].toDate(),
        completionDate = NullableJsonConverter().getFromJsonMaybe(
            json: json['completionDate'], transform: (it) => it.toDate()),
        completionPost = NullableJsonConverter().getFromJsonMaybe(
            json: json['completionPost'], transform: (it) => Post.fromJson(it)),
        posts = json['posts'].map<Post>((post) => Post.fromJson(post)).toList(),
        canBeRepliedTo = json['canBeRepliedTo'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'topics': topics.map((it) => it.toString()).toList(),
        'subTopics': subTopics.map((it) => it.toString()).toList(),
        'authorUsername': authorUsername,
        'startDate': startDate,
        'completionDate': completionDate,
        'completionPost': completionPost?.toJson(),
        'posts': posts.map((post) => post.toJson()).toList(),
        'canBeRepliedTo': canBeRepliedTo
      };

  @override
  int get hashCode =>
      title.hashCode ^
      topics.hashCode ^
      subTopics.hashCode ^
      authorUsername.hashCode ^
      startDate.hashCode ^
      completionDate.hashCode ^
      completionPost.hashCode ^
      posts.hashCode ^
      canBeRepliedTo.hashCode;

  @override
  bool operator ==(other) {
    return (other is Thread) &&
        other.title == title &&
        listEquals(other.topics, topics) &&
        listEquals(other.subTopics, subTopics) &&
        other.authorUsername == authorUsername &&
        other.startDate == startDate &&
        other.completionDate == completionDate &&
        other.completionPost == completionPost &&
        listEquals(other.posts, posts) &&
        other.canBeRepliedTo == canBeRepliedTo;
  }

  String toString() =>
      'Thread($title, $topics, $subTopics, $authorUsername, $startDate, $completionDate, $completionPost, $posts, $canBeRepliedTo)';

  Thread withTopics(List<Topic> newTopics) {
    if (completionDate == null) {
      throw Exception("Cannot add topics to a completed Thread");
    }
    return Thread(
        title: title,
        topics: newTopics,
        subTopics: subTopics,
        authorUsername: authorUsername,
        startDate: startDate,
        completionDate: completionDate,
        completionPost: completionPost,
        posts: posts,
        canBeRepliedTo: canBeRepliedTo);
  }

  Thread withSubTopics(List<SubTopic> newSubTopics) {
    if (completionDate == null) {
      throw Exception("Cannot add sub topics to a completed Thread");
    }
    return Thread(
        title: title,
        topics: topics,
        subTopics: newSubTopics,
        authorUsername: authorUsername,
        startDate: startDate,
        completionDate: completionDate,
        completionPost: completionPost,
        posts: posts,
        canBeRepliedTo: canBeRepliedTo);
  }

  Thread asCompleted(
          {required DateTime newCompletionDate,
          required Post? newCompletionPost}) =>
      Thread(
          title: title,
          topics: topics,
          subTopics: subTopics,
          authorUsername: authorUsername,
          startDate: startDate,
          completionDate: newCompletionDate,
          completionPost: newCompletionPost,
          posts: posts,
          canBeRepliedTo: false);

  Thread restoredAsIncomplete({required bool canBeRepliedTo}) => Thread(
      title: title,
      topics: topics,
      subTopics: subTopics,
      authorUsername: authorUsername,
      startDate: startDate,
      completionDate: null,
      completionPost: null,
      posts: posts,
      canBeRepliedTo: canBeRepliedTo);

  Thread withPosts(List<Post> newPosts) {
    if (completionDate == null) {
      throw Exception("Cannot add posts to a completed Thread");
    }
    return Thread(
        title: title,
        topics: topics,
        subTopics: subTopics,
        authorUsername: authorUsername,
        startDate: startDate,
        completionDate: completionDate,
        completionPost: completionPost,
        posts: newPosts,
        canBeRepliedTo: canBeRepliedTo);
  }
}
