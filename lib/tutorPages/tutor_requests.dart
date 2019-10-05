import 'package:flutter/material.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:tutor_me_demo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_me_demo/main.dart';

class RequestsPage extends StatefulWidget {
  static String tag = 'tutor_requests';
  final DocumentReference detailsUser;
  final DocumentSnapshot requests;

  RequestsPage({Key key, this.requests, this.detailsUser});
  @override
  _RequestsPageState createState() => _RequestsPageState();
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

class getRequests extends StatelessWidget {
  final List<DocumentSnapshot> documents;

  getRequests({this.documents});

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemExtent: 110.0,
      itemBuilder: (BuildContext context, int index) {
        String from = documents[index].data['From'].toString();
        String title =
            ('${from[0].toUpperCase()} ${from.split(" ").last[0].toUpperCase()}${from.split(" ").last.toString().substring(1).toLowerCase()}');

        return Padding(
          padding: const EdgeInsets.only(
              left: 0.0, top: 4.0, right: 0.0, bottom: 4.0),
          child: Card(
            color: Colors.grey[200],
            child: ListTile(
              title: Container(
                //padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          height: 50.0,
                          child: CircleAvatar(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.green,
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
                                return AlertDialog(
                                  title: new Text('Request from:'),
                                  content: new Text('${from} '),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        color: Colors.blueAccent,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: Icon(Icons.check_box),
                        onPressed: () {},
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                        color: Colors.red,
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
