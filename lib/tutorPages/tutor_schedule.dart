import 'package:flutter/material.dart';
import 'package:tutor_me_demo/constants.dart';
import 'package:intl/intl.dart';
import 'package:dropdownfield/dropdownfield.dart';

class Schedule extends StatelessWidget {
  static String tag = 'Schedule';
  List<String> mon = ["9:00 - 10:00"];
  List<String> tue = ["9:00 - 10:00", "12:00-13:00"];
  List<String> thu = ["9:00 - 10:00"];
  List<String> wed = [];
  List<String> fri = ["9:00 - 10:00", "11:00 - 12:00"];

  List<String> get arrm {
    return mon;
  }

  List<String> get arrt {
    return mon;
  }

  List<String> get arrw {
    return mon;
  }

  List<String> get arrmtu {
    return mon;
  }

  List<String> get arrmfi {
    return mon;
  }

  Schedule.monday(this.mon);
  Schedule.tue(this.tue);
  Schedule.wed(this.wed);
  Schedule.thu(this.thu);
  Schedule.friday(this.fri);
  Schedule();

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

List<DropdownMenuItem<String>> _dropDownItem() {
  List<String> ddl = ["9:00 - 10:00", "10:00 - 11:00", "11:00-12:00"];
  return ddl
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
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF285AE6), Color(0xFF41B7FC)]),
                ),
              ),
              title: Text(
                'Schedule',
                style: TextStyle(color: Colors.white),
              ),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    child:
                        Text("Monday", style: TextStyle(color: Colors.white)),
                    //text: "Tuesday",
                  ),
                  Tab(
                    child:
                        Text("Tuesday", style: TextStyle(color: Colors.white)),
                    //text: "Tuesday",
                  ),
                  Tab(
                    child: Text("Wednesday",
                        style: TextStyle(color: Colors.white)),
                  ),
                  Tab(
                    child:
                        Text("Thursday", style: TextStyle(color: Colors.white)),
                  ),
                  Tab(
                    child:
                        Text("Friday", style: TextStyle(color: Colors.white)),
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
                  content: DropdownButton(
                    value: _selection,
                    items: _dropDownItem(),
                    onChanged: (String value) {
                      _selection = value;
                      setState(() {
                        _selection;
                      });
                    },
                    hint: Text('Time slot'),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('Continue'),
                      onPressed: () {
                        Schedule n = Schedule();
                        int navTo = _tabController.index;
                        print(navTo);
                        if (navTo == 0) {
                          n.mon.add(_selection);
                          print(n.mon);
                        } else if (navTo == 1) {
                          n.tue.add(_selection);
                        } else if (navTo == 2) {
                          n.wed.add(_selection);
                        } else if (navTo == 3) {
                          n.thu.add(_selection);
                        } else {
                          n.fri.add(_selection);
                        }

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

Future<void> check(String) {}

class PageOne extends StatelessWidget {
  Schedule obj = Schedule();
  @override
  Widget build(BuildContext context) {
    var mon = obj.arrm;
    print(mon);
    return ListView.builder(
      itemCount: mon.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(mon[index],
                style:
                    new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
            subtitle: new Text('Monday'),
            leading: new Icon(
              Icons.timer,
              color: Colors.blue[500],
            ),
          ),
        );
      },
    );
  }
}

class PageTwo extends StatelessWidget {
  Schedule obj = Schedule();

  @override
  Widget build(BuildContext context) {
    var tue = obj.arrt;
    return ListView.builder(
      itemCount: tue.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(tue[index],
                style:
                    new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
            subtitle: new Text('Tuesday'),
            leading: new Icon(
              Icons.timer,
              color: Colors.blue[500],
            ),
          ),
        );
      },
    );
  }
}

class PageThree extends StatelessWidget {
  Schedule obj = Schedule();
  @override
  Widget build(BuildContext context) {
    var wed = obj.arrw;
    return ListView.builder(
      itemCount: wed.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(wed[index],
                style:
                    new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
            subtitle: new Text('Tuesday'),
            leading: new Icon(
              Icons.timer,
              color: Colors.blue[500],
            ),
          ),
        );
      },
    );
  }
}

class PageFour extends StatelessWidget {
  Schedule obj = Schedule();
  @override
  Widget build(BuildContext context) {
    var thu = obj.arrmtu;
    return ListView.builder(
      itemCount: thu.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(thu[index],
                style:
                    new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
            subtitle: new Text('Tuesday'),
            leading: new Icon(
              Icons.timer,
              color: Colors.blue[500],
            ),
          ),
        );
      },
    );
  }
}

class PageFive extends StatelessWidget {
  Schedule obj = Schedule();
  @override
  Widget build(BuildContext context) {
    var fri = obj.arrmfi;
    return ListView.builder(
      itemCount: fri.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(fri[index],
                style:
                    new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
            subtitle: new Text('Tuesday'),
            leading: new Icon(
              Icons.timer,
              color: Colors.blue[500],
            ),
          ),
        );
      },
    );
  }
}
