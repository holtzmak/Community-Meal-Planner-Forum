import 'package:app/core/flag_reason.dart';
import 'package:flutter/foundation.dart';

@immutable
class ThreadFlag {
  final String id; // Firebase Firestore ID
  final String threadId;
  final bool isAnnouncement;
  final FlagReason flagReason;

  ThreadFlag(
      {required this.id,
      required this.threadId,
      required this.isAnnouncement,
      required this.flagReason});

  ThreadFlag.empty({required String id, required bool isAnnouncement})
      : id = id,
        threadId = "",
        isAnnouncement = isAnnouncement,
        flagReason = FlagReason.unsure;

  ThreadFlag.fromJson({required String id, required Map<String, dynamic> json})
      : id = id,
        threadId = json['threadId'],
        isAnnouncement = json['isAnnouncement'],
        flagReason = FlagReasonDeserializer.fromString(json['flagReason']);

  Map<String, dynamic> toJson() => {
        'threadId': threadId,
        'isAnnouncement': isAnnouncement,
        'flagReason': flagReason.toString(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThreadFlag &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          threadId == other.threadId &&
          isAnnouncement == other.isAnnouncement &&
          flagReason == other.flagReason;

  @override
  int get hashCode =>
      id.hashCode ^
      threadId.hashCode ^
      isAnnouncement.hashCode ^
      flagReason.hashCode;

  @override
  String toString() {
    return 'ThreadFlag{id: $id, threadId: $threadId, isAnnouncement: $isAnnouncement, flagReason: $flagReason}';
  }
}
