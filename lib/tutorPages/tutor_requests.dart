import 'package:flutter/material.dart';
import 'package:tutor_me_demo/constants.dart';


class RequestsPage extends StatefulWidget {
  static String tag = 'tutor_requests';
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  static String tag = 'tutor_requests';
  List names = [
    'Farouk Francis',
    'Farouk Francis',
    'Farouk Francis',
    'Calvin Harrison',
    'Farouk Francis',
    'Ibraaheem Allie'
  ];
  List module = [
    'IFS 361',
    'CSC312',
    'ABC123',
    'Information Systems',
    'Computer Science',
    'Something Else'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color(0xFF6BCDFD),
        title: Text('My Requests'),
      ),
      drawer: ActualDrawer(),
      body: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 40.0,
                          height: 40.0,
                          child: CircleAvatar(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.green,
                              backgroundImage:
                                  AssetImage('images/profilePic.jpg')),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(names[index],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(module[index],
                                style: TextStyle(color: Colors.grey)),
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
                                  content: new Text('Farouk Francis'),
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
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                      child: IconButton(
                        icon: Icon(Icons.check),
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
              )),
    );
  }
}
