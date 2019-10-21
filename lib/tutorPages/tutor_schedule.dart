import 'package:flutter/material.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    String _selection;
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
              title: Text('Schedule'),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text('Select Time Slot'),
                  content: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: DropdownButton(
                          value: _selection,
                          items: _dropDownDay(),
                          onChanged: (String value) {
                            _selection = value;
                            setState(() {
                              String s0 = _selection;
                              sel0 = s0;
                            });
                          },
                          hint: Text('Day'),
                        ),
                      ),
                      new Expanded(
                        child: DropdownButton(
                          value: _selection,
                          items: _dropDownItem(),
                          onChanged: (String value) {
                            _selection = value;
                            setState(() {
                              String s1 = _selection;
                              sel1 = s1;
                            });
                          },
                          hint: Text('Time slot'),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('Continue'),
                      onPressed: () {
                        currmens.mens
                            .collection('Schedule')
                            .document()
                            .setData({
                          'Day': sel0,
                          'Time': sel1,
                        });
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}



class PageOne extends StatelessWidget {
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: currmens.mens
          .collection("Schedule")
          .where("Day", isEqualTo: "Monday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new ListTile(
                title: Text(document["Time"],
                    style: new TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20.0)),
                leading: new Icon(
                  Icons.timer,
                  color: Colors.blue[500],
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
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: currmens.mens
          .collection("Schedule")
          .where("Day", isEqualTo: "Tuesday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new ListTile(
                title: Text(document["Time"],
                    style: new TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20.0)),
                leading: new Icon(
                  Icons.timer,
                  color: Colors.blue[500],
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
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: currmens.mens
          .collection("Schedule")
          .where("Day", isEqualTo: "Wednesday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new ListTile(
                title: Text(document["Time"],
                    style: new TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20.0)),
                leading: new Icon(
                  Icons.timer,
                  color: Colors.blue[500],
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
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: currmens.mens
          .collection("Schedule")
          .where("Day", isEqualTo: "Thursday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new ListTile(
                title: Text(document["Time"],
                    style: new TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20.0)),
                leading: new Icon(
                  Icons.timer,
                  color: Colors.blue[500],
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
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: currmens.mens
          .collection("Schedule")
          .where("Day", isEqualTo: "Friday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new ListTile(
                title: Text(document["Time"],
                    style: new TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20.0)),
                leading: new Icon(
                  Icons.timer,
                  color: Colors.blue[500],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
