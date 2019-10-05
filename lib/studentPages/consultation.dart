import 'package:flutter/material.dart';
import 'package:tutor_me_demo/constants.dart';
import 'package:tutor_me_demo/main.dart';
import 'package:tutor_me_demo/studentPages/profile_page.dart';
import 'modules_page.dart';

class StudentConsultation extends StatefulWidget {
  @override
  _StudentConsultationState createState() => _StudentConsultationState();
}

class _StudentConsultationState extends State<StudentConsultation> {
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
        title: Text('Consultations'),
      ),
      
    );
  }
}