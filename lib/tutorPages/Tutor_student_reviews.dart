import 'package:flutter/material.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentReviews extends StatefulWidget {
  static String tag = 'tutor_requests';
  final DocumentReference detailsUser;
  final DocumentSnapshot requests;

  StudentReviews({Key key, this.requests, this.detailsUser});
  @override
  _StudentReviewsState createState() => _StudentReviewsState();
}

void inputData() async {
  DocumentReference user = currmens.mens;
  user.collection("Requests").snapshots();
}

class _StudentReviewsState extends State<StudentReviews> {
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
        title: Text('My Reviews'),
      ),
      body: StreamBuilder(
        stream: currmens.mens
            .collection('Ratings')
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
        String from = documents[index].data['By'].toString();
        String com = documents[index].data['Comment'].toString();
        double rating = documents[index].data['Rating'];
        String title =
            ('${from[0].toUpperCase()} ${from.split(" ").last[0].toUpperCase()}${from.split(" ").last.toString().substring(1).toLowerCase()}');
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
                                  '${documents[index].data['Avatar'].toString()}')),
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
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 15,
                                );
                              }),
                            ),
                          ],
                        ),
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
                                              new Text('Review From:\n$from'),
                                          content: Text('Comment: $com'),
                                          actions: <Widget>[],
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
