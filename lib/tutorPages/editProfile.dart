import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:tutor_me_demo/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class TutorBioEdit extends StatefulWidget {
  static String tag = "tutoredit";
  @override
  _TutorBioEditState createState() => _TutorBioEditState();
}

class _TutorBioEditState extends State<TutorBioEdit> {
  final tutorbioController = TextEditingController();
  final tutoruniController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    tutorbioController.dispose();
    tutoruniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF285AE6), Color(0xFF41B7FC)]),
          ),
        ),
        title: Text('Edit Your Details'),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new TextFormField(
                controller: tutoruniController,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.account_balance),
                  hintText: 'Insert what university you attend',
                  labelText: 'University',
                ),
              ),
              TextFormField(
                controller: tutorbioController,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.library_books),
                  hintText: 'How can you help students',
                  labelText: 'Bio',
                ),
              ),
            ],
          ),
        ),
      ),

      /*Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),*/
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          Firestore.instance
              .collection('Tutor')
              .document(currmens.mens.documentID)
              .updateData({'Bio': tutorbioController.text});
          Firestore.instance
              .collection('Tutor')
              .document(currmens.mens.documentID)
              .updateData({'uni': tutoruniController.text});
          Navigator.of(context, rootNavigator: false).pop();
        },

        tooltip: 'Show me the value!',
        child: Icon(Icons.add),
      ),
    );
  }
}
