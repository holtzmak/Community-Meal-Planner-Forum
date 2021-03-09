import 'package:flutter/material.dart';

import 'screen/home_screen.dart';

class CommunityMealPlannerForumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community of Meal Planners Forums',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
