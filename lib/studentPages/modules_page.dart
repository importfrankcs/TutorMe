import 'package:flutter/material.dart';
import 'package:tutor_me_demo/main.dart';
import 'package:tutor_me_demo/studentPages/profile_page.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModulesPage extends StatefulWidget {
  static String tag = 'modules-page';
  @override
  _MyModules createState() => _MyModules();
}

//Modules and their Respective COntainer colors
class _MyModules extends State<ModulesPage> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> entries = <String>[
    'IFS01',
    'CSC02',
    'ACC03',
    'PHY04',
    'IFS05',
    'CSC06',
    'TEST',
    'PHY08',
    'IFS09',
    'CSC10',
    'ACC11',
    'TEST',
    'CSC14',
    'ACC15',
    'PHY16'
  ];
  final List<int> colorCodes = <int>[
    50,
    100,
    200,
    300,
    400,
    50,
    100,
    200,
    300,
    400,
    50,
    100,
    200,
    300,
    400,
    100,
    200,
    300,
    400,
    50,
    100,
    200,
    300,
    400,
  ];


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6BCDFD),
        title: Text('Module List'),
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
      body:new ModuleList(),
    );
  }

}
class ModuleList extends StatelessWidget {
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection('Modules').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          children: snapshot.data.documents.map((document) {
            return new ListTile(
              title: new Center(child:Text(document['Code']),),
              subtitle: new Center(child: Text(document['Title']),),
              onTap: () {},
            );
          }).toList(),
        );
      },
    );
  }
}

//child: ListView.separated(
//padding: const EdgeInsets.all(8.0),
//itemCount: entries.length,
//itemBuilder: (BuildContext context, int index) {
//return Container(
//height: 50,
//color: Colors.blue

//child: Center(child: Text('Module: ${entries[index]}')),
//color: Colors.blue[colorCodes[index]],
//);
//},
//separatorBuilder: (BuildContext context, int index) =>
//const Divider(),
//),



//Stack(
//children: <Widget>[
//list(),
//SafeArea(
//child: SingleChildScrollView(
//child: Column(
//children: <Widget>[
//SizedBox(height: screenSize.height / 6.4),
//_tile(),
//],
//),
//),
//)
//],
//),