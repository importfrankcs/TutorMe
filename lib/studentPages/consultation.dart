import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
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
  var rating = 0.0;
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
                              content: Text(
                                'Please Rate your experience',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              actions: <Widget>[
                                
                              ],
                            ),
                            
                            Review(),
                            FlatButton(
                              child: Text(
                                "SUBMIT RATING",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                            FlatButton(
                              child: Text(
                                "CANCEL",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
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

    /*ListView.builder(
      itemCount: documents.length,
      itemExtent: 110.0,
      itemBuilder: (BuildContext context, int index) {
        String toStudent = documents[index].data['Student'].toString();
        String day = documents[index].data['Day'].toString();
        String modu = documents[index].data['Module'].toString();
        String time = documents[index].data['Time'].toString();
        String ven = documents[index].data['Venue'].toString();
        String tut = documents[index].data['Tutor'].toString();
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

/*


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
                                          title: new Text('Request From:\n$from'),
                                          content: Text('Module: $modu\nDay: $day\nTime: $time\nVenue: $ven\nDetails: \n$com'),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: new Text('ACCEPT', style: TextStyle(color: Colors.green),),
                                              onPressed: () {
                                                Firestore.instance.collection('Consultations').document().setData({
                                                  'Tutor': '${usern.username}',
                                                  'Module': '$modu',
                                                  'Day': '$day',
                                                  'Time': '$time',
                                                  'Venue': '$ven',
                                                  'Student': '$from'


                                                });
                                              },
                                            ),
                                            FlatButton(

                                              child: new Text('DECLINE', style: TextStyle(color: Colors.red),),
                                              onPressed: () {
                                                documents[index].reference.delete();
                                              },
                                            ),
                                             FlatButton(
                                              child: new Text('CLOSE', style: TextStyle(color: Colors.blue),),
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
*/
*/
  }
}
