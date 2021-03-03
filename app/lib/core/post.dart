import 'package:flutter/cupertino.dart';

import 'account.dart';

@immutable
class Post {
  final int postId;
  final Account author;
  final String message;
  final DateTime postDate;

  Post(
      {required this.postId,
      required this.author,
      required this.message,
      required this.postDate});

  Post.fromJson(Map<String, dynamic> json)
      : postId = json['postId'],
        author = Account.fromJson(json['author']),
        message = json['message'],
        postDate = json['postDate'].toDate();

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'author': author.toJson(),
        'message': message,
        'postDate': postDate
      };

  @override
  int get hashCode =>
      postId.hashCode ^ author.hashCode ^ message.hashCode ^ postDate.hashCode;

  @override
  bool operator ==(other) {
    return (other is Post) &&
        other.postId == postId &&
        other.author == author &&
        other.message == message &&
        other.postDate == postDate;
  }

  String toString() => 'Post($postId, $author, $message, $postDate)';
}
