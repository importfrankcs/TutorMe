import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:tutor_me_demo/constants.dart';
import 'package:tutor_me_demo/studentPages/edit_bio.dart';
import 'package:tutor_me_demo/tutorPages/tutor_schedule.dart';

class Bioedit extends StatefulWidget {
  static String tag = "bio edit";
  @override
  _BioeditState createState() => _BioeditState();
}

class _BioeditState extends State<Bioedit> {
  final studbioController = TextEditingController();
  final studuniController = TextEditingController();

  @override
  void dispose() {
    studbioController.dispose();
    studuniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit your details"),
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
                controller: studuniController,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.account_balance),
                  hintText: 'Insert what university you attend',
                  labelText: 'University',
                ),
              ),
              TextFormField(
                controller: studbioController,
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
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          Firestore.instance
              .collection('Tutor')
              .document(currmens.mens.documentID)
              .updateData({'Bio': studbioController.text});
          Firestore.instance
              .collection('Tutor')
              .document(currmens.mens.documentID)
              .updateData({'uni': studuniController.text});
        },

        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}
