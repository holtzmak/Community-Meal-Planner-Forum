import 'package:app/service/service_locator.dart';
import 'package:app/ui/community_meal_planner_forum_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ServiceLocator.setup();
  runApp(CommunityMealPlannerForumApp());
}
