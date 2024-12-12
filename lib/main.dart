import 'package:budget_tracker_app/views/home_page_dart.dart';
import 'package:budget_tracker_app/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const BudgetApp());
}

class BudgetApp extends StatelessWidget {
  const BudgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => UserProfilePage(),
        // HomePage route
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
          // Profile Page route
        ),
      ],
    );
  }
}
