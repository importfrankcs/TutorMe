import 'package:flutter/material.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart' as prefix0;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutor_me_demo/constants.dart';
import 'package:tutor_me_demo/studentPages/modules_page.dart';
import 'package:card_settings/card_settings.dart';

class TutorList extends StatefulWidget {
  final DocumentSnapshot tuts;
  final String buttonIndex;
  final DocumentReference detailsUser;
  final String username;
  TutorList(
      {this.tuts, this.buttonIndex, this.detailsUser, this.username, Key key})
      : super(key: key);

  @override
  _TutorList createState() => _TutorList();
}

//Modules and their Respective Container colors
class _TutorList extends State<TutorList> {
  @override
  void initState() {
    super.initState();
  }

//------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF285AE6), Color(0xFF41B7FC)]),
          ),
        ),
        title: Text('Pick a tutor'),
      ),
      //drawer:
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Tutor')
            .where("Module",
                isEqualTo: btnIn.btnIndex) //button name, enable dynamic var
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation(Colors.blueAccent),
            ));
          return FirestoreListView(documents: snapshot.data.documents);
        },
      ),
    );
  }
}

TextEditingController _textFieldController = TextEditingController();

class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  String timeValue;
  String dayValue;
  String comment;
  String venValue;
  TextEditingController com = new TextEditingController();

  FirestoreListView({this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: documents.length,
        itemExtent: 80.0,
        itemBuilder: (BuildContext context, int index) {
          String title = documents[index].data['displayName'].toString();
          //String module = documents[index].data['displayName'].toString();

          return ListTile(
            leading: CircleAvatar(
              //maxRadius: 20,
              backgroundImage: NetworkImage(documents[index].data['photoURL']),
            ),
            title: Text(
              documents[index].data['displayName'].toString(),
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15),
            ),
            subtitle: Container(
              child: SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < 2 ? Icons.star : Icons.star_border,
                      size: 15,
                    );
                  }),
                ),
              ),
            ),
            trailing: FlatButton(
              onPressed: (){
showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text('Select Time Slot'),
                      content: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              new Expanded(
                                  child: new DropdownButton<String>(
                                hint: Text("Select day"),
                                items: <String>[
                                  'Monday',
                                  'Tuesday',
                                  'Wednesday',
                                  'Thursday',
                                  'Friday'
                                ].map((value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  dayValue = value;
                                },
                              )),
                              Expanded(
                                  child: new DropdownButton<String>(
                                hint: Text("Select Time"),
                                items: <String>[
                                  '9:00-10:00',
                                  '10:00-11:00',
                                  '12:00-13:00',
                                  '14:00-15:00'
                                ].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  timeValue = value;
                                },
                              )),
                            ],
                          ),
                          new Expanded(
                              child: new DropdownButton<String>(
                            hint: Text("Select a venue."),
                            items: <String>['N22', 'SC2', 'SC3', 'B1', 'O2']
                                .map((value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              venValue = value;
                            },
                          )),
                          TextField(
                            controller: com,
                            decoration:
                                InputDecoration(hintText: "How can I help?"),
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
                            print(
                                "To : " + documents[index].data['displayName']);
                            String tut = documents[index].data['displayName'];
                            print("Module: " + btnIn.btnIndex);
                            String mod = btnIn.btnIndex;
                            print("From :" + prefix0.usern.username);
                            String from = prefix0.usern.username;

                            print(Firestore.instance
                                .collection('Requests')
                                .document()
                                .setData({
                              'To': tut,
                              'Module': mod,
                              'From': from,
                              'Day': dayValue,
                              'Time': timeValue,
                              'comment': comment,
                              'Venue': venValue,
                              'PhotoURL': documents[index].data['photoURL'],
                            }));
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
              },
              child: Text('REQUEST', style: TextStyle(color: Colors.blueAccent),),
            ),
            onLongPress: () {
              showDialog(
                    context: context,
                    // {Please work
                    builder: (BuildContext context) {
                      return Center(
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Center(
                                child: AlertDialog(
                                  title: Text(''),
                                  content: Text(''),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: new Text(
                                        'RATE',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      onPressed: () {},
                                    ),
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
            },
            //trailing: , Place Rating here
          );
        });
  }
}

/*

    padding: const EdgeInsets.only(
    left: 0.0, top: 4.0, right: 0.0, bottom: 4.0),
    child: ListTile(
    title: Container(
    padding: EdgeInsets.all(1.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Container(
    width: 50.0,
    height: 50.0,
    child: CircleAvatar(
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.blueAccent,
    backgroundImage: NetworkImage(
    '${documents[index].data['photoURL']}')),
    ),
    ),
    SizedBox(
    width: 8.0,
    ),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Text(title,
    textAlign: TextAlign.center,
    style: TextStyle(
    color: Colors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.bold)),
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
    builder: (BuildContext context) {
    return AlertDialog(
    title: new Text('Request'),
    content: new Text(
    "Hi my name is ${documents[index].data['displayName']}\n\nStruggling with ${btnIn.btnIndex}? \n\nI'd be happy to teach you!"),
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
    color: Colors.blue,
    ),
    ),
    Container(
    alignment: Alignment.centerRight,
    padding:
    EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
    child: IconButton(
    icon: Icon(Icons.check_box),


    onPressed: () {
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    title: new Text('Select Time Slot'),
    content: Column(
    children: <Widget>[
    Row(
    children: <Widget>[
    new Expanded(
    child: new DropdownButton<String>(
    hint: Text("Select day"),
    items: <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
    ].map((value) {
    return new DropdownMenuItem<
    String>(
    value: value,
    child: new Text(value),
    );
    }).toList(),
    onChanged: (value) {
    dayValue = value;
    },
    )),
    Expanded(
    child: new DropdownButton<String>(
    hint: Text("Select Time"),
    items: <String>[
    '9:00-10:00',
    '10:00-11:00',
    '12:00-13:00',
    '14:00-15:00'
    ].map((String value) {
    return new DropdownMenuItem<
    String>(
    value: value,
    child: new Text(value),
    );
    }).toList(),
    onChanged: (value) {
    timeValue = value;
    },
    )),
    ],
    ),
    new Expanded(
    child: new DropdownButton<String>(
    hint: Text("Select a venue."),
    items: <String>[
    'N22',
    'SC2',
    'SC3',
    'B1',
    'O2'
    ].map((value) {
    return new DropdownMenuItem<String>(
    value: value,
    child: new Text(value),
    );
    }).toList(),
    onChanged: (value) {
    venValue = value;
    },
    )),
    TextField(
    controller: com,
    decoration: InputDecoration(
    hintText: "How can I help?"),
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
    print("To : " +
    documents[index]
    .data['displayName']);
    String tut = documents[index]
    .data['displayName'];
    print("Module: " + btnIn.btnIndex);
    String mod = btnIn.btnIndex;
    print(
    "From :" + prefix0.usern.username);
    String from = prefix0.usern.username;

    print(Firestore.instance
    .collection('Requests')
    .document()
    .setData({
    'To': tut,
    'Module': mod,
    'From': from,
    'Day': dayValue,
    'Time': timeValue,
    'comment': comment,
    'Venue': venValue,
    'PhotoURL':
    documents[index].data['photoURL'],
    }));
    Navigator.of(context).pop();
    },
    )
    ],
    );
    });
    },
    color: Colors.green,
    ),
    ),
    ],
    ),
    ),
    ),

*/
