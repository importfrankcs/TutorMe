import 'package:flutter/material.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:tutor_me_demo/studentPages/edit_bio.dart';
import 'package:tutor_me_demo/tutorPages/Tutor_student_reviews.dart';
import 'package:tutor_me_demo/tutorPages/editProfile.dart';
import 'package:tutor_me_demo/tutorPages/tutor_completed.dart';
import 'package:tutor_me_demo/tutorPages/tutor_modules.dart';
import 'package:tutor_me_demo/tutorPages/tutor_requests.dart';
import 'package:tutor_me_demo/tutorPages/tutor_schedule.dart';
import 'landing_page.dart';
import 'package:tutor_me_demo/landing_page.dart';
import 'package:tutor_me_demo/studentPages/modules_page.dart';
import 'package:tutor_me_demo/studentPages/consultation.dart';
import 'package:tutor_me_demo/tutorPages/tutor_registerPage.dart';

// 10th Oct. HOPEFULLY THIS WORKS

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LandingPage.tag: (context) => LandingPage(),
    GoogleSignApp.tag: (context) => GoogleSignApp(),
    ModulesPage.tag: (context) => ModulesPage(),
    TutorRegister.tag: (context) => TutorRegister(),
    Schedule.tag: (context) => Schedule(),
    StudentReviews.tag: (context) => StudentReviews(),
    TutorConsultation.tag: (context) => TutorConsultation(),
    TutorModules.tag: (context) => TutorModules(),
    RequestsPage.tag: (context) => RequestsPage(),
    Consultation.tag: (context) => Consultation(),
    Bioedit.tag: (context) => Bioedit(),
    TutorBioEdit.tag: (context) => TutorBioEdit(),
    //TutStudReviews.tag: (context)
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MainPage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent, //Color(0xFF285AE6),
        accentColor: Color(0xFF285AE6), //Color(0xFF6BCDFD),
      ),
      initialRoute: LandingPage.tag,
      routes: routes,
      //even this can be a change* theis is for testing purposes
    );
  }
}
