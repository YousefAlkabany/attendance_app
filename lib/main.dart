import 'package:cattendanceapp/pages/home_page.dart';
import 'package:cattendanceapp/pages/login_page.dart';
import 'package:cattendanceapp/pages/profile/about_us_page.dart';
import 'package:cattendanceapp/pages/profile/change_password_page.dart';
import 'package:cattendanceapp/pages/profile/edit_profile_page.dart';
import 'package:cattendanceapp/pages/profile/privacy_policy_page.dart';
import 'package:cattendanceapp/pages/profile/terms_and_conditions_page.dart';
import 'package:cattendanceapp/pages/profile_page.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        HomePage.id: (context) => HomePage(),
        ProfilePage.id: (context) => const ProfilePage(),
        TermsAndConditionsPage.id: (context) => const TermsAndConditionsPage(),
        PrivacyPolicyPage.id: (context) => const PrivacyPolicyPage(),
        AboutUsPage.id: (context) => const AboutUsPage(),
        ChangePasswordPage.id: (context) => const ChangePasswordPage(),
        EditProfilePage.id: (context) => const EditProfilePage()
      },
      initialRoute: LoginPage.id,
    );
  }
}
