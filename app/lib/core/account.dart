import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

@immutable
class Account {
  final String id; // Firebase Firestore ID
  final String name;
  final List<String> titles;
  final String aboutMeDescription;
  final DateTime joinDate;

  Account(
      {required this.id,
      required this.name,
      required this.titles,
      required this.aboutMeDescription,
      required this.joinDate});

  Account.empty()
      : id = "",
        name = "",
        titles = [],
        aboutMeDescription = "",
        joinDate = DateTime.now();

  Account.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        titles = List<String>.from(json['titles']),
        aboutMeDescription = json['aboutMeDescription'],
        joinDate = json['joinDate'].toDate();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'titles': titles,
        'aboutMeDescription': aboutMeDescription,
        'joinDate': joinDate,
      };

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      titles.hashCode ^
      aboutMeDescription.hashCode ^
      joinDate.hashCode;

  @override
  bool operator ==(other) {
    return (other is Account) &&
        other.id == name &&
        other.name == name &&
        listEquals(other.titles, titles) &&
        other.aboutMeDescription == aboutMeDescription &&
        other.joinDate == joinDate;
  }

  String toString() =>
      'Account(id: $id, name: $name, titles: $titles, aboutMeDescription: $aboutMeDescription, joinDate: $joinDate)';

  Account withTitles(List<String> newTitles) => Account(
      id: id,
      name: name,
      titles: newTitles,
      aboutMeDescription: aboutMeDescription,
      joinDate: joinDate);

  Account withAboutMeDescription(String newDescription) => Account(
      id: id,
      name: name,
      titles: titles,
      aboutMeDescription: newDescription,
      joinDate: joinDate);
}
