import 'package:app/core/account.dart';
import 'package:app/core/post.dart';
import 'package:app/core/subtopic.dart';
import 'package:app/core/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/topic.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  final temp = Account(
                      username: "temp",
                      name: "Temp",
                      titles: ["Temp"],
                      aboutMeDescription: "",
                      joinDate: DateTime.now(),
                      threads: []);
                  FirebaseFirestore.instance
                      .collection("account")
                      .add(temp.toJson());
                },
                child: Text("Add Account to database")),
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection("account").get().then(
                      (QuerySnapshot snapshot) =>
                          snapshot.docs.forEach((result) {
                            print(Account.fromJson(result.data()!));
                          }));
                },
                child: Text("Get Account from database (see build output)")),
            ElevatedButton(
                onPressed: () {
                  final temp = Thread(
                      title: "Temp",
                      topics: [Topic.generalPractices],
                      subTopics: [SubTopic.critique],
                      authorUsername: "1234abc",
                      startDate: DateTime.now(),
                      completionDate: null,
                      completionPost: null,
                      posts: [],
                      canBeRepliedTo: true);
                  FirebaseFirestore.instance
                      .collection("thread")
                      .add(temp.toJson());
                },
                child: Text("Add Thread to database")),
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection("thread").get().then(
                      (QuerySnapshot snapshot) =>
                          snapshot.docs.forEach((result) {
                            print(Thread.fromJson(result.data()!));
                          }));
                },
                child: Text("Get Thread from database (see build output)")),
            ElevatedButton(
                onPressed: () {
                  final temp = Post(
                      authorUsername: "abcd1234",
                      message: "Temp",
                      postDate: DateTime.now());
                  FirebaseFirestore.instance
                      .collection("thread")
                      .doc("KwlWdzrsvp3PxOx5Rndb")
                      .collection("post")
                      .add(temp.toJson());
                },
                child: Text("Add Post to database")),
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("thread")
                      .doc("KwlWdzrsvp3PxOx5Rndb")
                      .collection("post")
                      .get()
                      .then((QuerySnapshot snapshot) =>
                          snapshot.docs.forEach((result) {
                            print(Post.fromJson(result.data()!));
                          }));
                },
                child: Text("Get Post from database (see build output)")),
          ],
        ),
      ),
    );
  }
}
