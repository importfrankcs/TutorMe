import 'package:flutter/material.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
//import 'package:tutor_me_demo/Login_Authentification/TutorLogin.dart';
import 'package:tutor_me_demo/constants.dart';
import 'package:intl/intl.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_me_demo/studentPages/consultation.dart';
import 'package:tutor_me_demo/studentPages/tutorList.dart';

class pick_time_of_tut extends StatelessWidget {
  static String tag = "tutor_schedule";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Color(0xFF6BCDFD),
        accentColor: Color(0xFF6BCDFD),
        textTheme: TextTheme(
            //
            ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

void inputData() async {
  final DocumentReference user = currmens.mens;
  user.collection("Schedule").snapshots();

  // here you write the codes to input the data into firestore
}

List<DropdownMenuItem<String>> _dropDownItem() {
  List<String> ddl = ["9:00 - 10:00", "10:00 - 11:00", "11:00-12:00"];
  return ddl
      .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();
}

void submit(String ven, String time, String day, String comments) {
  Firestore.instance.collection('Requests').document().setData({
    'To': alldata.to,
    'Module': alldata.mod,
    'From': alldata.from,
    'PhotoURL': alldata.photo,
    'Day': day,
    'Time': time,
    'Venue': ven,
    'Comment': comments,
  });
}

List<DropdownMenuItem<String>> _dropDownDay() {
  List<String> dd = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
  return dd
      .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;
  //list of times
  //List<String> _values = new List<String>();
  @override
  void initState() {
    //times
    // _values.addAll(["9:00 - 10:00", "10:00 - 11:00"]);
    // String _value = _values.elementAt(0);

    // void_onChanged(String value){
    //   setState(() {
    //     _value = value;
    //   });
    // }

    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  String sel0 = '';
  String sel1 = '';

  var tutor = Firestore.instance.collection("Tutor").snapshots().first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              title: Text('Pick A Time Slot'),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                isScrollable: true,
                tabs: <Widget>[
                  Tab(text: "Monday", icon: new Icon(Icons.calendar_today)),
                  Tab(
                    text: "Tuesday",
                  ),
                  Tab(
                    text: "Wednesday",
                  ),
                  Tab(
                    text: "Thursday",
                  ),
                  Tab(
                    text: "Friday",
                  ),
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            PageOne(),
            PageTwo(),
            PageThree(),
            PageFour(),
            PageFive(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
//retrieveVenues () async {

//final documents = await db.collection('Venues').getDocuments();
//final userObject = documents.documents.first.data;
//}

Future<void> check(String) {}

class PageOne extends StatelessWidget {
  String timeValue;
  String dayValue;
  String comment;
  String venValue;
  TextEditingController com = new TextEditingController();
  String _selection;
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: tutref.ref
          .collection("Schedule")
          .where("Day", isEqualTo: "Monday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new Container(
                height: 70.0,
                child: new RaisedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: new Text('Select Time Slot'),
                            content: Column(
                              children: <Widget>[
                                new Expanded(
                                    child: new DropdownButton<String>(
                                  hint: Text("Select a venue."),
                                  items: <String>[
                                    'N22',
                                    'SC2',
                                    'SC3',
                                    'B1',
                                    'O2'
                                  ].map((value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    venValue = value;
                                  },
                                )),
                                TextField(
                                  controller: com,
                                  decoration: InputDecoration(
                                      hintText: "Type your problem area(s)"),
                                  onChanged: (value) {
                                    comment = com.text;
                                  },
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('SUBMIT REQUEST'),
                                onPressed: () {
                                  submit(venValue, document["Time"], "Monday",
                                      comment);
                                },
                              )
                            ],
                          );
                        });
                  },
                  icon: new Icon(Icons.timer),
                  color: Colors.white70,
                  label: Text(document["Time"],
                      style: new TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0)),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class PageTwo extends StatelessWidget {
  String timeValue;
  String dayValue;
  String comment;
  String venValue;
  TextEditingController com = new TextEditingController();
  String _selection;
  String currentVal;
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: tutref.ref
          .collection("Schedule")
          .where("Day", isEqualTo: "Tuesday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new Container(
                height: 70.0,
                child: new RaisedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: new Text('Select Time Slot'),
                            content: Column(
                              children: <Widget>[
                                new Expanded(
                                    child: new DropdownButton<String>(
                                  hint: Text("Select a venue."),
                                  items: <String>[
                                    'N22',
                                    'SC2',
                                    'SC3',
                                    'B1',
                                    'O2'
                                  ].map((value) {
                                    return new DropdownMenuItem<String>(
                                      value: currentVal,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    currentVal = value;
                                  },
                                )),
                                TextField(
                                  controller: com,
                                  decoration: InputDecoration(
                                      hintText: "Type your problem area(s)"),
                                  onChanged: (value) {
                                    comment = com.text;
                                  },
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('SUBMIT REQUEST'),
                                onPressed: () {
                                  submit(venValue, document["Time"], "Tuesday",
                                      comment);
                                },
                              )
                            ],
                          );
                        });
                  },
                  icon: new Icon(Icons.timer),
                  color: Colors.white70,
                  label: Text(document["Time"],
                      style: new TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0)),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class PageThree extends StatelessWidget {
  String timeValue;
  String dayValue;
  String comment;
  String venValue;
  TextEditingController com = new TextEditingController();
  String _selection;
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: tutref.ref
          .collection("Schedule")
          .where("Day", isEqualTo: "Wednesday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new Container(
                height: 70.0,
                child: new RaisedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: new Text('Select Time Slot'),
                            content: Column(
                              children: <Widget>[
                                new Expanded(
                                    child: new DropdownButton<String>(
                                  hint: Text("Select a venue."),
                                  items: <String>[
                                    'N22',
                                    'SC2',
                                    'SC3',
                                    'B1',
                                    'O2'
                                  ].map((value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    venValue = value;
                                  },
                                )),
                                TextField(
                                  controller: com,
                                  decoration: InputDecoration(
                                      hintText: "Type your problem area(s)"),
                                  onChanged: (value) {
                                    comment = com.text;
                                  },
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('SUBMIT REQUEST'),
                                onPressed: () {
                                  submit(venValue, document["Time"],
                                      "Wednesday", comment);
                                },
                              )
                            ],
                          );
                        });
                  },
                  icon: new Icon(Icons.timer),
                  color: Colors.white70,
                  label: Text(document["Time"],
                      style: new TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0)),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class PageFour extends StatelessWidget {
  String timeValue;
  String dayValue;
  String comment;
  String venValue;
  TextEditingController com = new TextEditingController();
  String _selection;
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: tutref.ref
          .collection("Schedule")
          .where("Day", isEqualTo: "Thursday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new Container(
                height: 70.0,
                child: new RaisedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: new Text('Select Time Slot'),
                            content: Column(
                              children: <Widget>[
                                new Expanded(
                                    child: new DropdownButton<String>(
                                  hint: Text("Select a venue."),
                                  items: <String>[
                                    'N22',
                                    'SC2',
                                    'SC3',
                                    'B1',
                                    'O2'
                                  ].map((value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    venValue = value;
                                  },
                                )),
                                TextField(
                                  controller: com,
                                  decoration: InputDecoration(
                                      hintText: "Type your problem area(s)"),
                                  onChanged: (value) {
                                    comment = com.text;
                                  },
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('SUBMIT REQUEST'),
                                onPressed: () {
                                  submit(venValue, document["Time"], "Thursday",
                                      comment);
                                },
                              )
                            ],
                          );
                        });
                  },
                  icon: new Icon(Icons.timer),
                  color: Colors.white70,
                  label: Text(document["Time"],
                      style: new TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0)),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class PageFive extends StatelessWidget {
  String timeValue;
  String dayValue;
  String comment;
  String venValue;
  TextEditingController com = new TextEditingController();
  String _selection;
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: tutref.ref
          .collection("Schedule")
          .where("Day", isEqualTo: "Friday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new Container(
                height: 70.0,
                child: new RaisedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: new Text('Select Time Slot'),
                            content: Column(
                              children: <Widget>[
                                new Expanded(
                                    child: new DropdownButton<String>(
                                  hint: Text("Select a venue."),
                                  items: <String>[
                                    'N22',
                                    'SC2',
                                    'SC3',
                                    'B1',
                                    'O2'
                                  ].map((value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    venValue = value;
                                  },
                                )),
                                TextField(
                                  controller: com,
                                  decoration: InputDecoration(
                                      hintText: "Type your problem area(s)"),
                                  onChanged: (value) {
                                    comment = com.text;
                                  },
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('SUBMIT REQUEST'),
                                onPressed: () {
                                  submit(venValue, document["Time"], "Friday",
                                      comment);
                                },
                              )
                            ],
                          );
                        });
                  },
                  icon: new Icon(Icons.timer),
                  color: Colors.white70,
                  label: Text(document["Time"],
                      style: new TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0)),
                ),
              );

              //child: Text(document["Time"],style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
              //leading: new Icon(
              // Icons.timer,
              // color: Colors.blue[500],
              //),
              //onPressed: (){},
              //);
            }).toList(),
          ),
        );
      },
    );
  }
}
