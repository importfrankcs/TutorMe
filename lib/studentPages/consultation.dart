import 'package:flutter/material.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_me_demo/constants.dart';

class Consultation extends StatefulWidget {
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
          String com = widget.documents[index].data['comment'].toString();

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
            trailing: IconButton(
              icon: Icon(Icons.info),color: Colors.blueAccent,
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
}

class getRequests extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  getRequests({this.documents});

  @override
  _getRequestsState createState() => _getRequestsState();
}

class _getRequestsState extends State<getRequests> {
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
          String com = widget.documents[index].data['comment'].toString();

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
            trailing: IconButton(
              icon: Icon(Icons.info),color: Colors.blueAccent,
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
                              title: new Text('Request From:\n$toStudent', style: TextStyle(
                                color: Colors.blueAccent
                              ),),
                              content: Text(
                                  'Module: $modu\nDay: $day\nTime: $time\nVen: $ven\nDetails: \n$com'),
                              actions: <Widget>[
                                

                                  FlatButton(
                                    child: new Text(
                                      'CLOSE',
                                      style:
                                      TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                            )

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
}

class getCompleted extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  getCompleted({this.documents});

  @override
  _getCompletedState createState() => _getCompletedState();
}

class _getCompletedState extends State<getCompleted> {
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
          String com = widget.documents[index].data['comment'].toString();

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
            trailing: IconButton(
              icon: Icon(Icons.info), color: Colors.blueAccent,
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
                              title: new Text('Request From:\n$toStudent',style: TextStyle(
                                color: Colors.blueAccent
                              )),
                              content: Text(
                                  'Module: $modu\nDay: $day\nTime: $time\nVen: $ven\nDetails: \n$com'),
                              actions: <Widget>[
                                

                                FlatButton(
                                  child: new Text(
                                    'CLOSE',
                                    style:
                                    TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ],
                            )

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
}

class getDeclined extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  getDeclined({this.documents});

  @override
  _getDeclinedState createState() => _getDeclinedState();
}

class _getDeclinedState extends State<getDeclined> {
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
          String com = widget.documents[index].data['comment'].toString();

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
            trailing: IconButton(
              icon: Icon(Icons.info),color: Colors.blueAccent,
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
                              title: new Text('Request From:\n$toStudent', style: TextStyle(
                                color: Colors.blueAccent
                              )),
                              content: Text(
                                  'Module: $modu\nDay: $day\nTime: $time\nVen: $ven\nDetails: \n$com'),
                              actions: <Widget>[

                                  FlatButton(
                                    child: new Text(
                                      'CLOSE',
                                      style:
                                      TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                            )

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
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
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
    //Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Requests')
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
          return getRequests(documents: snapshot.data.documents);
        },
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
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

class PageThree extends StatelessWidget {
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('CompletedSessions')
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
          return getCompleted(documents: snapshot.data.documents);
        },
      ),
    );

  }
}

class PageFour extends StatelessWidget {
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Declined')
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
          return getDeclined(documents: snapshot.data.documents);
        },
      ),
    );

  }

}
