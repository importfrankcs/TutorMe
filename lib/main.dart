import 'package:flutter/material.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:tutor_me_demo/ProfileScreen.dart';

import 'package:tutor_me_demo/tutorPages/Tutor_student_reviews.dart';
import 'package:tutor_me_demo/tutorPages/tutor_completed.dart';
import 'package:tutor_me_demo/tutorPages/tutor_modules.dart';
import 'package:tutor_me_demo/tutorPages/tutor_schedule.dart';

import 'landing_page.dart';
import 'package:tutor_me_demo/landing_page.dart';
import 'package:tutor_me_demo/studentPages/modules_page.dart';

//import 'package:tutor_me_demo/Login_Authentification/StudentLogin.dart';
import 'package:tutor_me_demo/Login_Authentification/TutorLogin.dart';
import 'package:tutor_me_demo/tutorPages/tutor_registerPage.dart';
import 'package:flutter_redux/flutter_redux.dart';

//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:google_sign_in/google_sign_in.dart';
// this is also very useless text for test purpsoes

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LandingPage.tag: (context) => LandingPage(),
    TutorLogin.tag: (context) => TutorLogin(),
    GoogleSignApp.tag: (context) => GoogleSignApp(),
    ModulesPage.tag: (context) => ModulesPage(),
    TutorRegister.tag: (context) => TutorRegister(),
    Schedule.tag: (context) => Schedule(),
    StudentReviews.tag: (conext) => StudentReviews(),
    CompletedSessions.tag: (context) => CompletedSessions(),
    TutorModules.tag: (context) => TutorModules(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MainPage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF285AE6),
        accentColor: Color(0xFF285AE6), //Color(0xFF6BCDFD),
      ),
      initialRoute: LandingPage.tag,
      routes: routes,
      //even this can be a change* theis is for testing purposes
    );
  }
}
