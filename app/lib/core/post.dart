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

// factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

// Map<String, dynamic> toJson() => _$PostToJson(this);
}
