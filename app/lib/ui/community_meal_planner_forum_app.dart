import 'package:app/ui/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

class CommunityMealPlannerForumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community of Meal Planners Forums',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUpScreen(),
    );
  }
}
