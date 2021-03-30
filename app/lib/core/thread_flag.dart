import 'package:app/core/flag_reason.dart';
import 'package:flutter/foundation.dart';

@immutable
class ThreadFlag {
  final String id; // Firebase Firestore ID
  final String threadId;
  final FlagReason flagReason;

  ThreadFlag(
      {required this.id, required this.threadId, required this.flagReason});

  ThreadFlag.empty(String id)
      : id = id,
        threadId = "",
        flagReason = FlagReason.unsure;

  ThreadFlag.fromJson({required String id, required Map<String, dynamic> json})
      : id = id,
        threadId = json['threadId'],
        flagReason = FlagReasonDeserializer.fromString(json['flagReason']);

  Map<String, dynamic> toJson() => {
        'threadId': threadId,
        'flagReason': flagReason.toString(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThreadFlag &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          threadId == other.threadId &&
          flagReason == other.flagReason;

  @override
  int get hashCode => id.hashCode ^ threadId.hashCode ^ flagReason.hashCode;

  @override
  String toString() {
    return 'ThreadFlag{id: $id, threadId: $threadId, flagReason: $flagReason}';
  }
}
