import 'package:app/core/post.dart';
import 'package:app/core/subtopic.dart';
import 'package:app/core/topic.dart';
import 'package:flutter/cupertino.dart';

import 'account.dart';

@immutable
class Thread {
  final int threadId;
  final String title;
  final List<Topic> topics;
  final List<SubTopic> subTopics;
  final Account author;
  final DateTime startDate;
  final DateTime? completionDate;
  final Post? completionPost;
  final List<Post> posts;
  final bool canBeRepliedTo;

  Thread(
      {required this.threadId,
      required this.title,
      required this.topics,
      required this.subTopics,
      required this.author,
      required this.startDate,
      required this.completionDate,
      required this.completionPost,
      required this.posts,
      required this.canBeRepliedTo});

  // factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);

  // Map<String, dynamic> toJson() => _$ThreadToJson(this);

  Thread withTopics(List<Topic> newTopics) {
    if (completionDate == null) {
      throw Exception("Cannot add topics to a completed Thread");
    }
    return Thread(
        threadId: threadId,
        title: title,
        topics: newTopics,
        subTopics: subTopics,
        author: author,
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
        threadId: threadId,
        title: title,
        topics: topics,
        subTopics: newSubTopics,
        author: author,
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
          threadId: threadId,
          title: title,
          topics: topics,
          subTopics: subTopics,
          author: author,
          startDate: startDate,
          completionDate: newCompletionDate,
          completionPost: newCompletionPost,
          posts: posts,
          canBeRepliedTo: false);

  Thread restoredAsIncomplete({required bool canBeRepliedTo}) => Thread(
      threadId: threadId,
      title: title,
      topics: topics,
      subTopics: subTopics,
      author: author,
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
        threadId: threadId,
        title: title,
        topics: topics,
        subTopics: subTopics,
        author: author,
        startDate: startDate,
        completionDate: completionDate,
        completionPost: completionPost,
        posts: newPosts,
        canBeRepliedTo: canBeRepliedTo);
  }
}
