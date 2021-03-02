import 'package:app/core/thread.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Account {
  final String username;
  final String name;
  final List<String> titles;
  final String aboutMeDescription;
  final DateTime joinDate;
  final List<Thread> threads;

  Account(
      {required this.username,
      required this.name,
      required this.titles,
      required this.aboutMeDescription,
      required this.joinDate,
      required this.threads});

  // factory Account.fromJson(Map<String, dynamic> json) =>
  //     _$AccountFromJson(json);

  // Map<String, dynamic> toJson() => _$AccountToJson(this);

  Account withTitles(List<String> newTitles) => Account(
      username: username,
      name: name,
      titles: newTitles,
      aboutMeDescription: aboutMeDescription,
      joinDate: joinDate,
      threads: threads);

  Account withAboutMeDescription(String newDescription) => Account(
      username: username,
      name: name,
      titles: titles,
      aboutMeDescription: newDescription,
      joinDate: joinDate,
      threads: threads);

  Account withThreads(List<Thread> newThreads) => Account(
      username: username,
      name: name,
      titles: titles,
      aboutMeDescription: aboutMeDescription,
      joinDate: joinDate,
      threads: newThreads);
}
