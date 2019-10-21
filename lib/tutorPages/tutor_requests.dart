import 'package:flutter/material.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestsPage extends StatefulWidget {
  static String tag = 'tutor_requests';
  final DocumentReference detailsUser;
  final DocumentSnapshot requests;

  RequestsPage({Key key, this.requests, this.detailsUser});
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

void inputData() async {
  DocumentReference user = currmens.mens;
  user.collection("Requests").snapshots();
}

class _RequestsPageState extends State<RequestsPage> {
  static String tag = 'tutor_requests';

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
        title: Text('My Requests'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Requests')
            .where("To",
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

String username = usern.username;

class getRequests extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  getRequests({this.documents});

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemExtent: 110.0,
      itemBuilder: (BuildContext context, int index) {
        String from = documents[index].data['From'].toString();
        String day = documents[index].data['Day'].toString();
        String modu = documents[index].data['Module'].toString();
        String time = documents[index].data['Time'].toString();
        String ven = documents[index].data['Venue'].toString();
        String com = documents[index].data['Comment'].toString();
        String userid = documents[index].data['uid'].toString();
        String title =
            ('${from[0].toUpperCase()} ${from.split(" ").last[0].toUpperCase()}${from.split(" ").last.toString().substring(1).toLowerCase()}');
        String daytitle =
            ('${day[0].toUpperCase()} ${day.split(" ").last[0].toUpperCase()}${day.split(" ").last.toString().substring(1).toLowerCase()}');
        String module =
            ('${modu[0].toUpperCase()} ${modu.split(" ").last[0].toUpperCase()}${modu.split(" ").last.toString().substring(1).toLowerCase()}');

        String times =
            ('${time[0].toUpperCase()} ${time.split(" ").last[0].toUpperCase()}${time.split(" ").last.toString().substring(1).toLowerCase()}');

        String venue =
            ('${ven[0].toUpperCase()} ${ven.split(" ").last[0].toUpperCase()}${ven.split(" ").last.toString().substring(1).toLowerCase()}');

        String comment =
            ('${com[0].toUpperCase()} ${com.split(" ").last[0].toUpperCase()}${com.split(" ").last.toString().substring(1).toLowerCase()}');
        return Padding(
          padding: const EdgeInsets.only(
              left: 0.0, top: 4.0, right: 0.0, bottom: 4.0),
          child: Card(
            color: Colors.grey[200],
            child: ListTile(
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          height: 50.0,
                          child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                  '${documents[index].data['PhotoURL'].toString()}')),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11.0,
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
                              // {Please work
                              builder: (BuildContext context) {
                                return Center(
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                        child: AlertDialog(
                                          title:
                                              new Text('Request From:\n$from'),
                                          content: Text(
                                              'Module: $modu\nDay: $day\nTime: $time\nVen: $ven\nDetails: \n$com'),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: new Text(
                                                'ACCEPT',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                              onPressed: () {
                                                Firestore.instance
                                                    .collection('Consultations')
                                                    .document()
                                                    .setData({
                                                  'Tutor': '${usern.username}',
                                                  'Module': '$modu',
                                                  'Day': '$day',
                                                  'Time': '$time',
                                                  'Venue': '$ven',
                                                  'Student': '$from',
                                                  'comment': '$com',
                                                  'uid': '$userid',
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              child: new Text(
                                                'DECLINE',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                Firestore.instance
                                                    .collection('Declined')
                                                    .document()
                                                    .setData({
                                                  'Tutor': '${usern.username}',
                                                  'Module': '$modu',
                                                  'Day': '$day',
                                                  'Time': '$time',
                                                  'Venue': '$ven',
                                                  'Student': '$from',
                                                  'comment': '$com',
                                                  'uid': '$userid',
                                                });
                                                documents[index]
                                                    .reference
                                                    .delete();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              child: new Text(
                                                'CLOSE',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
