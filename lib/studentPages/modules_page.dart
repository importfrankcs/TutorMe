import 'package:flutter/material.dart';
import 'package:tutor_me_demo/constants.dart';
import 'package:tutor_me_demo/landing_page.dart';
import 'package:tutor_me_demo/main.dart';
import 'package:tutor_me_demo/studentPages/profile_page.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_me_demo/studentPages/tutorList.dart';

class ModulesPage extends StatefulWidget {
  static String tag = 'modules-page';
  @override
  _MyModules createState() => _MyModules();
}

class ButtonIndex {
  String btnIndex;
  ButtonIndex({this.btnIndex});
}

final btnIn = ButtonIndex(btnIndex: '');

//Modules and their Respective Container colors
class _MyModules extends State<ModulesPage> {
  @override
  void initState() {
    super.initState();
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
        title: Text('Module List'),
      ),
      body: new ModuleList(),
    );
  }
}

var colorsarray = [
  Colors.blueAccent,
  Colors.redAccent,
  Colors.greenAccent,
  Colors.deepPurpleAccent,
  Colors.orangeAccent,
  Colors.purpleAccent,
];

class ModuleList extends StatelessWidget {
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection('Modules').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return new GridView.count(
          crossAxisCount: 2,
          children: snapshot.data.documents.map((document) {
            return GridView.builder(
                itemCount: 1
                ,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    color:
                        colorsarray[snapshot.data.documents.indexOf(document)],
                    elevation: 5.0,
                    child: InkWell(
                      onTap: () {
                        btnIn.btnIndex = document.data.values.elementAt(1);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TutorList(
                              buttonIndex: btnIn.btnIndex,
                            ),
                          ),
                        );
                      },
                      child: new Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                document['Code'],
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(document['Title'],
                                  style: TextStyle(color: Colors.white))
                            ],
                          )),
                    ),
                  );
                });
          }).toList(),
        );
      },
    );
  }
}

/*
  class ModuleList extends StatelessWidget {
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection('Modules').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return ListView(
          children: snapshot.data.documents.map((document) {
            return new ListTile(
              title: new Center(
                child: Text(document['Code']),
              ),
              subtitle: new Center(
                child: Text(document['Title']),
              ),
              onTap: () {
                btnIn.btnIndex = document.data.values.elementAt(1);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TutorList(
                            buttonIndex: btnIn.btnIndex,
                          )),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
  */
