import 'package:flutter/cupertino.dart';

@immutable
class Post {
  final String authorUsername;
  final String message;
  final DateTime postDate;

  Post(
      {required this.authorUsername,
      required this.message,
      required this.postDate});

  Post.fromJson(Map<String, dynamic> json)
      : authorUsername = json['authorUsername'],
        message = json['message'],
        postDate = json['postDate'].toDate();

  Map<String, dynamic> toJson() => {
        'authorUsername': authorUsername,
        'message': message,
        'postDate': postDate
      };

  @override
  int get hashCode =>
      authorUsername.hashCode ^ message.hashCode ^ postDate.hashCode;

  @override
  bool operator ==(other) {
    return (other is Post) &&
        other.authorUsername == authorUsername &&
        other.message == message &&
        other.postDate == postDate;
  }

  String toString() => 'Post($authorUsername, $message, $postDate)';
}
