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
        title: Text('Tutor Modules',textAlign: TextAlign.center,)

      ),
      drawer: ActualDrawer(),
    );
  }
}