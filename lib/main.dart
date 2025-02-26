import 'package:cattendanceapp/firebase_options.dart';
import 'package:cattendanceapp/pages/applications/all_application_page.dart';
import 'package:cattendanceapp/pages/applications/apply_application_page.dart';
import 'package:cattendanceapp/pages/home_page.dart';
import 'package:cattendanceapp/pages/login_page.dart';
import 'package:cattendanceapp/pages/profile/about_us_page.dart';
import 'package:cattendanceapp/pages/profile/change_password_page.dart';
import 'package:cattendanceapp/pages/profile/edit_profile_page.dart';
import 'package:cattendanceapp/pages/profile/privacy_policy_page.dart';
import 'package:cattendanceapp/pages/profile/terms_and_conditions_page.dart';
import 'package:cattendanceapp/pages/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        HomePage.id: (context) => HomePage(),
        ProfilePage.id: (context) => const ProfilePage(),
        TermsAndConditionsPage.id: (context) => TermsAndConditionsPage(),
        PrivacyPolicyPage.id: (context) => PrivacyPolicyPage(),
        AboutUsPage.id: (context) => AboutUsPage(),
        ChangePasswordPage.id: (context) => const ChangePasswordPage(),
        EditProfilePage.id: (context) => const EditProfilePage() , 
        AllApplicationPage.id : (context)=>const AllApplicationPage() , 
        ApplyApplicationPage.id : (context)=>const ApplyApplicationPage() , 
      },
      initialRoute: LoginPage.id,
    );
  }
}
