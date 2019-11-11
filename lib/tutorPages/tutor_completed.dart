import 'package:flutter/material.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompletedSessions extends StatefulWidget {
  final DocumentReference detailsUser;
  final DocumentSnapshot consul;

  CompletedSessions({Key key, this.consul, this.detailsUser});
  @override
  _CompletedSessionsState createState() => _CompletedSessionsState();
}

void inputData() async {
  DocumentReference user = currmens.mens;
  user.collection("CompletedSessions").snapshots();
}

class _CompletedSessionsState extends State<CompletedSessions> {
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
        title: Text('Your Completed Sessions'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('CompletedSessions')
            .where("Tutor",
                isEqualTo:
                    "${usern.username}") //button name, enable dynamic var
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
            ));
          return getCompletedSessions(documents: snapshot.data.documents);
        },
      ),
    );
  }
}

String username = usern.username;

class getCompletedSessions extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  getCompletedSessions({this.documents});

  @override
  _getCompletedSessionsState createState() => _getCompletedSessionsState();
}

class _getCompletedSessionsState extends State<getCompletedSessions> {
  final ratingcomment = TextEditingController();
  var rating = 0.0;
  final studbioController = TextEditingController();

  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.documents.length,
        itemExtent: 110.0,
        itemBuilder: (BuildContext context, int index) {
          String stud = widget.documents[index].data['Student'].toString();
          String day = widget.documents[index].data['Day'].toString();
          String time = widget.documents[index].data['Time'].toString();
          String ven = widget.documents[index].data['Venue'].toString();
          String tut = widget.documents[index].data['Tutor'].toString();
          String userid = widget.documents[index].data['uid'].toString();
          String com = widget.documents[index].data['Comment'].toString();

          return ListTile(
            //leading: Text(documents[index].data['displayName'].toString()),
            //leading: ,
            title: Row(children: <Widget>[
              Text("Module: ", style: TextStyle(fontWeight: FontWeight.w500)),
            ]),
            subtitle: Row(children: <Widget>[
              Text("Student: ", style: TextStyle(fontWeight: FontWeight.w800)),
              Text(stud),
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
                                'Session Details:',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              content: Column(
                                children: <Widget>[
                                  Text(
                                      "Tutor: $tut\nStudent: $stud\nDay: $day\nVenue:$ven\nTime:$time\nComment: $com"),
                                  FlatButton(
                                    child: Text(
                                      "CLOSE",
                                      style: TextStyle(color: Colors.blueAccent),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
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

class getConsultations extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  getConsultations({this.documents});

  @override
  _getConsultationsState createState() => _getConsultationsState();
}

class _getConsultationsState extends State<getConsultations> {
  final ratingcomment = TextEditingController();
  var rating = 0.0;
  final studbioController = TextEditingController();

  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.documents.length,
        itemExtent: 110.0,
        itemBuilder: (BuildContext context, int index) {
          String stud = widget.documents[index].data['Student'].toString();
          String day = widget.documents[index].data['Day'].toString();
          String modu = widget.documents[index].data['Module'].toString();
          String time = widget.documents[index].data['Time'].toString();
          String ven = widget.documents[index].data['Venue'].toString();
          String tut = widget.documents[index].data['Tutor'].toString();
          String userid = widget.documents[index].data['uid'].toString();
          String com = widget.documents[index].data['Comment'].toString();

          return ListTile(
            //leading: Text(documents[index].data['displayName'].toString()),
            //leading: ,
            title: Row(children: <Widget>[
              Text("Module: ", style: TextStyle(fontWeight: FontWeight.w500)),
              Text(modu),
            ]),
            subtitle: Row(children: <Widget>[
              Text("Student: ", style: TextStyle(fontWeight: FontWeight.w800)),
              Text(stud),
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
                              title: new Text('Request From:\n$stud', style: TextStyle(color: Colors.blueAccent)),
                              content: Text(
                                  "Tutor: $tut\nStudent: $stud\nDay: $day\nVenue:$ven\nTime:$time\nComment: $com"),
                              actions: <Widget>[
                                FlatButton(
                                    child: new Text(
                                      'CLOSE',
                                      style: TextStyle(color: Colors.blue),
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
          String stud = widget.documents[index].data['Student'].toString();
          String day = widget.documents[index].data['Day'].toString();
          String modu = widget.documents[index].data['Module'].toString();
          String time = widget.documents[index].data['Time'].toString();
          String ven = widget.documents[index].data['Venue'].toString();
          String tut = widget.documents[index].data['Tutor'].toString();
          String userid = widget.documents[index].data['uid'].toString();
          String com = widget.documents[index].data['Comment'].toString();

          return ListTile(
            //leading: Text(documents[index].data['displayName'].toString()),
            //leading: ,
            title: Row(children: <Widget>[
              Text("Module: ", style: TextStyle(fontWeight: FontWeight.w500)),
              Text(modu),
            ]),
            subtitle: Row(children: <Widget>[
              Text("Student: ", style: TextStyle(fontWeight: FontWeight.w800)),
              Text(stud),
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
                              title: new Text('Request From:\n$stud',style: TextStyle(color: Colors.blueAccent)),
                              content: Text(
                                  "Tutor: $tut\nStudent: $stud\nDay: $day\nVenue:$ven\nTime:$time\nComment: $com"),
                              actions: <Widget>[
                                FlatButton(
                                    child: new Text(
                                      'CLOSE',
                                      style: TextStyle(color: Colors.blue),
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

class TutorConsultation extends StatefulWidget {
  static String tag = 'consultation';
  @override
  _TutorConsultationState createState() => _TutorConsultationState();
}

class _TutorConsultationState extends State<TutorConsultation>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
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
            .collection('Consultations')
            .where("Tutor",
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

class PageTwo extends StatelessWidget {
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('CompletedSessions')
            .where("Tutor",
                isEqualTo:
                    "${usern.username}") //button name, enable dynamic var
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
            ));
          return getCompletedSessions(documents: snapshot.data.documents);
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
            .collection('Declined')
            .where("Tutor",
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
