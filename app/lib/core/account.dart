import 'package:app/core/thread.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

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

  Account.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        name = json['name'],
        titles = List<String>.from(json['titles']),
        aboutMeDescription = json['aboutMeDescription'],
        joinDate = json['joinDate'].toDate(),
        threads = json['threads']
            .map<Thread>((thread) => Thread.fromJson(thread))
            .toList();

  Map<String, dynamic> toJson() => {
        'username': username,
        'name': name,
        'titles': titles,
        'aboutMeDescription': aboutMeDescription,
        'joinDate': joinDate,
        "threads": threads.map((thread) => thread.toJson()).toList()
      };

  @override
  int get hashCode =>
      username.hashCode ^
      name.hashCode ^
      titles.hashCode ^
      aboutMeDescription.hashCode ^
      joinDate.hashCode ^
      threads.hashCode;

  @override
  bool operator ==(other) {
    return (other is Account) &&
        other.username == name &&
        other.name == name &&
        listEquals(other.titles, titles) &&
        other.aboutMeDescription == aboutMeDescription &&
        other.joinDate == joinDate &&
        listEquals(other.threads, threads);
  }

  String toString() =>
      'Account($username, $name, $titles, $aboutMeDescription, $joinDate, $threads)';

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
