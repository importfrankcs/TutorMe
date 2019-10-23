import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tutor_me_demo/constants.dart';
import 'package:tutor_me_demo/studentPages/tutorList.dart';

/*class Consultation extends StatefulWidget {
  static String tag = 'consultation';
  final DocumentReference detailsUser;
  final DocumentSnapshot consul;

  Consultation({Key key, this.consul, this.detailsUser});
  @override
  _ConsultationState createState() => _ConsultationState();
}

void inputData() async {
  DocumentReference user = currmens.mens;
  user.collection("Consultations").snapshots();
}

class _ConsultationState extends State<Consultation> {
  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF285AE6), Color(0xFF41B7FC)]),
          ),
        ),
        backgroundColor: Color(0xFF6BCDFD),
        title: Text('My Consultations'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Consultations')
            .where("Student",
                isEqualTo:
                    "${usern.username}") //button name, enable dynamic var
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
            ));
          return getConsultations(documents: snapshot.data.documents);
        },
      ),
    );
  }
}

String username = usern.username;

class getConsultations extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  getConsultations({this.documents});

  @override
  _getConsultationsState createState() => _getConsultationsState();
}

TextEditingController com = new TextEditingController();
String comment;

class _getConsultationsState extends State<getConsultations> {
  final ratingcomment = TextEditingController();
  var rating = 0.0;
  final studbioController = TextEditingController();

  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.documents.length,
        itemExtent: 110.0,
        itemBuilder: (BuildContext context, int index) {
          String toStudent = widget.documents[index].data['Student'].toString();
          String day = widget.documents[index].data['Day'].toString();
          String modu = widget.documents[index].data['Module'].toString();
          String time = widget.documents[index].data['Time'].toString();
          String ven = widget.documents[index].data['Venue'].toString();
          String tut = widget.documents[index].data['Tutor'].toString();
          String userid = widget.documents[index].data['uid'].toString();
          String title =
              ('${toStudent[0].toUpperCase()} ${toStudent.split(" ").last[0].toUpperCase()}${toStudent.split(" ").last.toString().substring(1).toLowerCase()}');
          String daytitle =
              ('${day[0].toUpperCase()} ${day.split(" ").last[0].toUpperCase()}${day.split(" ").last.toString().substring(1).toLowerCase()}');
          String module =
              ('${modu[0].toUpperCase()} ${modu.split(" ").last[0].toUpperCase()}${modu.split(" ").last.toString().substring(1).toLowerCase()}');

          String times =
              ('${time[0].toUpperCase()} ${time.split(" ").last[0].toUpperCase()}${time.split(" ").last.toString().substring(1).toLowerCase()}');

          String venue =
              ('${ven[0].toUpperCase()} ${ven.split(" ").last[0].toUpperCase()}${ven.split(" ").last.toString().substring(1).toLowerCase()}');

          String tutor =
              ('${tut[0].toUpperCase()} ${tut.split(" ").last[0].toUpperCase()}${tut.split(" ").last.toString().substring(1).toLowerCase()}');
//documents[index].data['displayName'].toString()
          return ListTile(
            //leading: Text(documents[index].data['displayName'].toString()),
            //leading: ,
            title: Row(children: <Widget>[
              Text("Module: ", style: TextStyle(fontWeight: FontWeight.w500)),
              Text(modu),
            ]),
            subtitle: Row(children: <Widget>[
              Text("Tutor: ", style: TextStyle(fontWeight: FontWeight.w800)),
              Text(tut),
            ]),

            isThreeLine: true,
            trailing:
                //FlatButton(
                //child: Container(
                //  child: Text("RATE",
                //       style: TextStyle(color: Colors.blueAccent)),
                //  ),
                //   onPressed: () {
                //    print("fuck");
                //    },
                //   ),
                IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                showDialog(
                    context: context,
                    // {Please work
                    builder: (BuildContext context) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AlertDialog(
                              title: Text(
                                'Thank you For\nusing TUTOR ME',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              content: Column(
                                children: <Widget>[
                                  Text(
                                    'Please Rate your experience',
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                  TextFormField(
                                    controller: studbioController,
                                    decoration: const InputDecoration(
                                      icon: const Icon(Icons.add_comment),
                                      hintText: 'optional comment',
                                      labelText: 'leave a comment?',
                                    ),
                                  ),
                                  /*SafeArea(
                                    top: false,
                                    bottom: false,
                                    child: Form(
                                      autovalidate: true,
                                      child: new ListView(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        children: <Widget>[
                                          new TextFormField(
                                            controller: ratingcomment,
                                            decoration: const InputDecoration(
                                              icon: const Icon(
                                                  Icons.account_balance),
                                              hintText:
                                                  'Insert what university you attend',
                                              labelText: 'University',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )*/
                                ],
                              ),
                            ),
                            Review(),
                            FlatButton(
                              child: Text(
                                "SUBMIT RATING",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Firestore.instance
                                    .collection('Tutor')
                                    .document(widget
                                        .documents[index].data['uid']
                                        .toString())
                                    .collection('Ratings')
                                    .document()
                                    .setData({
                                  'Rating': rates.rate,
                                  'By': usern.username,
                                  'Comment': studbioController.text,
                                  'Avatar': currmensid.id,
                                });
                                Firestore.instance
                                    .collection('CompletedSessions')
                                    .document()
                                    .setData({
                                  'Student': widget
                                      .documents[index].data['Student']
                                      .toString(),
                                  'Day': widget.documents[index].data['Day']
                                      .toString(),
                                  'Module': widget
                                      .documents[index].data['Module']
                                      .toString(),
                                  'Time': widget.documents[index].data['Time']
                                      .toString(),
                                  'Venue': widget.documents[index].data['Venue']
                                      .toString(),
                                  'Tutor': widget.documents[index].data['Tutor']
                                      .toString(),
                                  'uid': widget.documents[index].data['uid']
                                      .toString(),
                                });
                                widget.documents[index].reference.delete();
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text(
                                "NO THANKS",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Firestore.instance
                                    .collection('CompletedSessions')
                                    .document()
                                    .setData({
                                  'Student': widget
                                      .documents[index].data['Student']
                                      .toString(),
                                  'Day': widget.documents[index].data['Day']
                                      .toString(),
                                  'Module': widget
                                      .documents[index].data['Module']
                                      .toString(),
                                  'Time': widget.documents[index].data['Time']
                                      .toString(),
                                  'Venue': widget.documents[index].data['Venue']
                                      .toString(),
                                  'Tutor': widget.documents[index].data['Tutor']
                                      .toString(),
                                  'uid': widget.documents[index].data['uid']
                                      .toString(),
                                });
                                widget.documents[index].reference.delete();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
            //trailing: , Place Rating here
          );
        });
  }
}*/
import 'package:flutter/material.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Consultation extends StatelessWidget {
  static String tag = "consultation";

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
    "11:00 - 12:10",
    "12:10 - 13:00"
  ];
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
    _tabController = TabController(vsync: this, length: 4);
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
              title: Text('Sessions', style: TextStyle(color: Colors.white)),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    child:
                        Text("Pending", style: TextStyle(color: Colors.white)),
                  ),
                  Tab(
                    child:
                        Text("Accepted", style: TextStyle(color: Colors.white)),
                  ),
                  Tab(
                    child: Text("Completed",
                        style: TextStyle(color: Colors.white)),
                  ),
                  Tab(
                    child:
                        Text("Declined", style: TextStyle(color: Colors.white)),
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
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance
          .collection("Requests")
          .where("From", isEqualTo: usern.username)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new ListTile(
                title: Text("Working",
                    style: new TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18.0)),
                leading: new Icon(
                  Icons.hourglass_empty,
                  color: Colors.blue[600],
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
      stream: Firestore.instance
          .collection("Consultations")
          .where("Student", isEqualTo: usern.username.toString())
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              
              return new ListTile(
                
                title: Text(document["Student"],
                    style: new TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18.0)),
                leading: new Icon(
                  Icons.check_circle,
                  color: Colors.blue[600],
                ),
                //------------------------------------------------------->
                onTap: (){
                
                });
            }).toList(),
          ),
        );
      },
    );
  }
}

class PageThree extends StatelessWidget {
     final ratingcomment = TextEditingController();
   
  var rating = 0.0;
  final studbioController = TextEditingController();
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance
          .collection("CompletedSessions")
          .where("Student", isEqualTo: usern.username)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new ListTile(
                title: Text(document["Time"],
                    style: new TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18.0)),
                leading: new Icon(
                  Icons.done_all,
                  color: Colors.blue[600],
                ),onTap: (){
                    
                showDialog(
                  
                    context: context,
                    // {Please work
                    builder: (BuildContext context) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AlertDialog(
                              title: Text(
                                'Thank you For\nusing TUTOR ME',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              content: Column(
                                children: <Widget>[
                                  Text(
                                    'Please Rate your experience',
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                  TextFormField(
                                    controller: studbioController,
                                    decoration: const InputDecoration(
                                      icon: const Icon(Icons.add_comment),
                                      hintText: 'optional comment',
                                      labelText: 'leave a comment?',
                                    ),
                                  ),
                                  /*SafeArea(
                                    top: false,
                                    bottom: false,
                                    child: Form(
                                      autovalidate: true,
                                      child: new ListView(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        children: <Widget>[
                                          new TextFormField(
                                            controller: ratingcomment,
                                            decoration: const InputDecoration(
                                              icon: const Icon(
                                                  Icons.account_balance),
                                              hintText:
                                                  'Insert what university you attend',
                                              labelText: 'University',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )*/
                                ],
                              ),
                            ),
                            Review(),
                            FlatButton(
                              child: Text(
                                "SUBMIT RATING",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                
                              },
                            ),
                            FlatButton(
                              child: Text(
                                "NO THANKS",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                
                              },
                            ),
                          ],
                        ),
                      );
                    });
                },
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
      stream: Firestore.instance
          .collection("Declined")
          .where("Student", isEqualTo: usern.username)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Card(
          child: new ListView(
            children: snapshot.data.documents.map((document) {
              return new ListTile(
                title: Text(document["Time"],
                    style: new TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18.0)),
                leading: new Icon(
                  Icons.access_time,
                  color: Colors.blue[600],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
