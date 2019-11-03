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
        String from = documents[index]
                .data['Student']
                .toString()
                .substring(0, 1)
                .toUpperCase() +
            ' ' +
            documents[index]
                .data['Student']
                .toString()
                .split(' ')
                .toList()[documents[index]
                        .data['Student']
                        .toString()
                        .split(' ')
                        .toList()
                        .length -
                    1][0]
                .toUpperCase()
                .toString() +
            documents[index]
                .data['Student']
                .toString()
                .split(' ')
                .toList()[documents[index]
                        .data['Student']
                        .toString()
                        .split(' ')
                        .toList()
                        .length -
                    1]
                .substring(1)
                .toLowerCase()
                .toString();
        String day = documents[index].data['Day'].toString();
        String modu = documents[index].data['Module'].toString();
        String time = documents[index].data['Time'].toString();
        String ven = documents[index].data['Venue'].toString();
        String com = documents[index].data['Comment'].toString();
        String userid = documents[index].data['uid'].toString();

        return Card(
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
                          Text(from,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.normal)),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(Icons.info),
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
                                        title: new Text('Request From:\n$from'),
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
                                                'Student': documents[index]
                                                    .data['Student'],
                                                'Comment': '$com',
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
                                              'DECLINE',
                                              style:
                                                  TextStyle(color: Colors.red),
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
                                                'Student': documents[index]
                                                    .data['Student'],
                                                'Comment': '$com',
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
                                              style:
                                                  TextStyle(color: Colors.blue),
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
        );
      },
    );
  }
}
