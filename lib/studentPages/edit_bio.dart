import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';

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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF285AE6), Color(0xFF41B7FC)]),
          ),
        ),
        //backgroundColor: Color(0xFF6BCDFD),
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
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          Firestore.instance
              .collection('Student')
              .document(currmens.mens.documentID)
              .updateData({'Bio': studbioController.text});
          Firestore.instance
              .collection('Student')
              .document(currmens.mens.documentID)
              .updateData({'uni': studuniController.text});
          print(currmens.mens.documentID);
          Navigator.of(context, rootNavigator: false).pop();
        },

        tooltip: 'Show me the value!',
        child: Icon(
          Icons.arrow_forward,
        ),
      ),
      
    );
  }
}
