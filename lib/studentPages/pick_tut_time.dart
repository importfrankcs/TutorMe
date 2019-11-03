import 'package:flutter/material.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<String> ddl = [
    "8:30 - 9:40",
    "9:40 - 10:50",
    "10:50 - 11:00",
    "11:00 - 12:00",
    "12:00 - 13:00",
    "13:00 - 14:10",
    "14:10 - 15:20",
    "15:20 - 16:30",
    "16:30 - 17:40",
    "17:40 - 18:50",
    "18:50 - 20:00",
    "20:00 - 21:00",
  ];
  return ddl
      .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();
}

void submit(String ven, String time, String day, String comments) {
  Firestore.instance.collection('Requests').document().setData({
    'Tutor': alldata.to,
    'Module': alldata.mod,
    'uid': alldata.uid,
    'Student': alldata.from,
    'PhotoURL': alldata.photo,
    'Day': day,
    'Time': time,
    'Venue': ven,
    'Comment': comments,
    //'To': to,
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
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF285AE6), Color(0xFF41B7FC)]),
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              title: Text('Pick A Time Slot',
                  style: TextStyle(color: Colors.white)),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                      child: Text("Monday",
                          style: TextStyle(color: Colors.white))),
                  Tab(
                      child: Text("Tuesday",
                          style: TextStyle(color: Colors.white))),
                  Tab(
                      child: Text("Wednesday",
                          style: TextStyle(color: Colors.white))),
                  Tab(
                      child: Text("Thursday",
                          style: TextStyle(color: Colors.white))),
                  Tab(
                      child: Text("Friday",
                          style: TextStyle(color: Colors.white))),
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

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  String timeValue;

  String dayValue;

  String comment;

  String venValue;

  TextEditingController com = new TextEditingController();

  String _selection;

  List<String> _items = <String>[
    '',
    'N22',
    'SC2',
    'SC3',
    'B1',
    'O2'
  ]; //.map((value);
  String _item = '';

  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: tutref.ref
          .collection("Schedule")
          .where("Day", isEqualTo: "Monday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: Container(
              child: Center(child: CircularProgressIndicator()),
            ),
          );
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
                            title: Text(
                              'Select Time Slot',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                FormField<String>(
                                  autovalidate: true,
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        icon: const Icon(Icons.place),
                                        labelText: 'Suggest a Venue',
                                      ),
                                      isEmpty: _item == '',
                                      child: new DropdownButtonHideUnderline(
                                        child: new DropdownButton<String>(
                                          value: _item,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              //newContact.favoriteColor = newValue;
                                              _item = newValue;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: _items.map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                TextFormField(
                                  controller: com,
                                  decoration: const InputDecoration(
                                    icon: const Icon(Icons.account_balance),
                                    hintText: 'short and sweet',
                                    labelText: 'How can I help',
                                  ),
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
                                  submit(_item, document["Time"], "Monday",
                                      comment);
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.calendar_today),
                  color: Colors.white,
                  label: Text(document["Time"],
                      style: new TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 20.0)),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  String timeValue;
  String dayValue;
  String comment;
  String venValue;
  TextEditingController com = new TextEditingController();
  String _selection;
  String currentVal;
  List<String> _items = <String>[
    '',
    'N22',
    'SC2',
    'SC3',
    'B1',
    'O2'
  ]; //.map((value);
  String _item = '';

  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: tutref.ref
          .collection("Schedule")
          .where("Day", isEqualTo: "Tuesday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new Container(
                height: 60.0,
                child: new RaisedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Select Time Slot',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            content: Column(
                              children: <Widget>[
                                FormField<String>(
                                  autovalidate: true,
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        icon: const Icon(Icons.place),
                                        labelText: 'Suggest a Venue',
                                      ),
                                      isEmpty: _item == '',
                                      child: new DropdownButtonHideUnderline(
                                        child: new DropdownButton<String>(
                                          value: _item,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              //newContact.favoriteColor = newValue;
                                              _item = newValue;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: _items.map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                TextFormField(
                                  controller: com,
                                  decoration: const InputDecoration(
                                    icon: const Icon(Icons.account_balance),
                                    hintText: 'short and sweet',
                                    labelText: 'How can I help',
                                  ),
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
                                  submit(_item, document["Time"], "Tuesday",
                                      comment);
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.calendar_today),
                  color: Colors.white,
                  label: Text(document["Time"],
                      style: new TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 20.0)),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class PageThree extends StatefulWidget {
  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  String timeValue;

  String dayValue;

  String comment;

  String venValue;

  TextEditingController com = new TextEditingController();

  String _selection;
  List<String> _items = <String>[
    '',
    'N22',
    'SC2',
    'SC3',
    'B1',
    'O2'
  ]; //.map((value);
  String _item = '';

  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: tutref.ref
          .collection("Schedule")
          .where("Day", isEqualTo: "Wednesday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
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
                            title: Text(
                              'Select Time Slot',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            content: Column(
                              children: <Widget>[
                                FormField<String>(
                                  autovalidate: true,
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        icon: const Icon(Icons.place),
                                        labelText: 'Suggest a Venue',
                                      ),
                                      isEmpty: _item == '',
                                      child: new DropdownButtonHideUnderline(
                                        child: new DropdownButton<String>(
                                          value: _item,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              //newContact.favoriteColor = newValue;
                                              _item = newValue;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: _items.map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                TextFormField(
                                  controller: com,
                                  decoration: const InputDecoration(
                                    icon: const Icon(Icons.account_balance),
                                    hintText: 'short and sweet',
                                    labelText: 'How can I help',
                                  ),
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
                                  submit(_item, document["Time"], "Wednesday",
                                      comment);
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.calendar_today),
                  color: Colors.white,
                  label: Text(document["Time"],
                      style: new TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 20.0)),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class PageFour extends StatefulWidget {
  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  String timeValue;

  String dayValue;

  String comment;

  String venValue;

  TextEditingController com = new TextEditingController();

  String _selection;
  List<String> _items = <String>[
    '',
    'N22',
    'SC2',
    'SC3',
    'B1',
    'O2'
  ]; //.map((value);
  String _item = '';

  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: tutref.ref
          .collection("Schedule")
          .where("Day", isEqualTo: "Thursday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
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
                            title: Text(
                              'Select Time Slot',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            content: Column(
                              children: <Widget>[
                                FormField<String>(
                                  autovalidate: true,
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        icon: const Icon(Icons.place),
                                        labelText: 'Suggest a Venue',
                                      ),
                                      isEmpty: _item == '',
                                      child: new DropdownButtonHideUnderline(
                                        child: new DropdownButton<String>(
                                          value: _item,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              //newContact.favoriteColor = newValue;
                                              _item = newValue;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: _items.map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                TextFormField(
                                  controller: com,
                                  decoration: const InputDecoration(
                                    icon: const Icon(Icons.account_balance),
                                    hintText: 'short and sweet',
                                    labelText: 'How can I help',
                                  ),
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
                                  submit(_item, document["Time"], "Thursday",
                                      comment);
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.calendar_today),
                  color: Colors.white,
                  label: Text(document["Time"],
                      style: new TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 20.0)),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class PageFive extends StatefulWidget {
  @override
  _PageFiveState createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  String timeValue;

  String dayValue;

  String comment;

  String venValue;

  TextEditingController com = new TextEditingController();

  List<String> _items = <String>[
    '',
    'N22',
    'SC2',
    'SC3',
    'B1',
    'O2'
  ]; //.map((value);
  String _item = '';
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: tutref.ref
          .collection("Schedule")
          .where("Day", isEqualTo: "Friday")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
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
                            title: Text(
                              'Select Time Slot',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            content: Column(
                              children: <Widget>[
                                FormField<String>(
                                  autovalidate: true,
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        icon: const Icon(Icons.place),
                                        labelText: 'Suggest a Venue',
                                      ),
                                      isEmpty: _item == '',
                                      child: new DropdownButtonHideUnderline(
                                        child: new DropdownButton<String>(
                                          value: _item,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              //newContact.favoriteColor = newValue;
                                              _item = newValue;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: _items.map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                TextFormField(
                                  controller: com,
                                  decoration: const InputDecoration(
                                    icon: const Icon(Icons.account_balance),
                                    hintText: 'short and sweet',
                                    labelText: 'How can I help',
                                  ),
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
                                  submit(_item, document["Time"], "Friday",
                                      comment);
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.calendar_today),
                  color: Colors.white,
                  label: Text(document["Time"],
                      style: new TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 20.0)),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
