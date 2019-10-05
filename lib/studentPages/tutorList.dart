import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart' as prefix0;
import 'package:tutor_me_demo/landing_page.dart';
import 'package:tutor_me_demo/main.dart';
import 'package:tutor_me_demo/studentPages/profile_page.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tutor_me_demo/studentPages/modules_page.dart';

class TutorList extends StatefulWidget {
  final DocumentSnapshot tuts;
  final String buttonIndex;
  final DocumentReference detailsUser;
  final String username;
  TutorList(
      {this.tuts, this.buttonIndex, this.detailsUser, this.username, Key key})
      : super(key: key);

  @override
  _TutorList createState() => _TutorList();
}

//Modules and their Respective Container colors
class _TutorList extends State<TutorList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF285AE6), Color(0xFF41B7FC)]),
              ),
            ),
        //backgroundColor: Color(0xFF6BCDFD),
        title: Text('Pick a tutor'),
      ),
      //drawer: 
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Tutor')
            .where("Module",
                isEqualTo: btnIn.btnIndex) //button name, enable dynamic var
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation(Colors.blueAccent),
            ));
          return FirestoreListView(documents: snapshot.data.documents);
        },
      ),
    );
  }
}

class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;

  FirestoreListView({this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: documents.length,
        itemExtent: 110.0,
        itemBuilder: (BuildContext context, int index) {
          String title = documents[index].data['displayName'].toString();

          return Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 4.0, right: 0.0, bottom: 4.0),
            child: ListTile(
              title: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                ),
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            child: CircleAvatar(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.green,
                                backgroundImage: NetworkImage(
                                    '${documents[index].data['photoURL']}')),
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5.0,
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                      child: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text('Request'),
                                  content: new Text(
                                      "Hi my name is ${documents[index].data['displayName']}\n\nStruggling with ${btnIn.btnIndex}? \n\nI'd be happy to teach you!"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                      child: IconButton(
                        icon: Icon(Icons.check_box),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text('Request'),
                                  content: new Text(
                                      "Thanks ${prefix0.usern.username}, \nYour request has been sent!"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                          print("To : " + documents[index].data['displayName']);
                          String tut = documents[index].data['displayName'];
                          print("Module: " + btnIn.btnIndex);
                          String mod = btnIn.btnIndex;
                          print("From :" + prefix0.usern.username);
                          String from = prefix0.usern.username;
                          print(Firestore.instance
                              .collection('Requests')
                              .document()
                              .setData({
                            'To': tut,
                            'Module': mod,
                            'From': from,
                          }));
                        },
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

//TO DO: button must be dynamic click the tick, send req to tutor page
