import 'package:app/core/thread.dart';

class ThreadToDisplay {
  final bool isAnnouncement;
  final Thread thread;

  ThreadToDisplay({required this.isAnnouncement, required this.thread});

  @override
  String toString() {
    return 'ThreadToDisplay{isAnnouncement: $isAnnouncement, thread: $thread}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThreadToDisplay &&
          runtimeType == other.runtimeType &&
          isAnnouncement == other.isAnnouncement &&
          thread == other.thread;

  @override
  int get hashCode => isAnnouncement.hashCode ^ thread.hashCode;
}
