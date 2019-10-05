import 'package:flutter/material.dart';
import 'package:tutor_me_demo/constants.dart';

class TutorModules extends StatefulWidget {
  static String tag = 'tutor_modules';
  @override
  _TutorModulesState createState() => _TutorModulesState();
}

class _TutorModulesState extends State<TutorModules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF285AE6), Color(0xFF41B7FC)]),
              ),
            ),
        title: Text('Tutor Modules',textAlign: TextAlign.center,)

      ),
      
    );
  }
}