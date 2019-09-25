import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart' as prefix0;
import 'package:tutor_me_demo/main.dart';
import 'package:tutor_me_demo/studentPages/profile_page.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_me_demo/studentPages/tutorList.dart';
import 'package:tutor_me_demo/studentPages/modules_page.dart';

class TutorList extends StatefulWidget {
  final DocumentSnapshot tuts;
  final String buttonIndex;
  final DocumentReference detailsUser;
  TutorList({this.tuts, this.buttonIndex, this.detailsUser, Key key})
      : super(key: key);

  @override
  _TutorList createState() => _TutorList();
}

//Modules and their Respective COntainer colors
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
        backgroundColor: Color(0xFF6BCDFD),
        title: Text('Pick a tutor'),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('images/profilePic.jpg'),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF6BCDFD),
                ),
                accountEmail: Text('3689674@myuwc.ac.za'),
                accountName: Text('Alex Knox'),
              ),
              FlatButton(
                onPressed: () {
                  /*Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );*/
                },
                child: ListTile(
                  //Todo: Chip and or trialing for alerts!
                  leading: Icon(Icons.account_circle),
                  title: Text('Home Page'),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: ListTile(
                  leading: Icon(Icons.question_answer),
                  title: Text('Consultation Sessions'),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text('Support'),
                ),
              ),
              Divider(),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.power_settings_new),
                      title: Text('LogOut'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

          return ListTile(
            title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black),
              ),
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 40.0,
                        height: 40.0,
                        child: CircleAvatar(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.green,
                            backgroundImage:
                                AssetImage('images/profilePic.jpg')),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 8.0,
                                  fontWeight: FontWeight.normal)),
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
                                content: new Text('Farouk Francis'),
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
                      onPressed: () {},
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

//TO DO: button must be dynamic click the tick, send req to tutor page
