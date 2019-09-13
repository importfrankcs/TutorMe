import 'package:flutter/material.dart';

class CompletedSessions extends StatefulWidget {
  static String tag = 'Completed schedules';

  @override
  _CompletedSessionsState createState() => _CompletedSessionsState();
}

class _CompletedSessionsState extends State<CompletedSessions> {
  @override
  Widget build(BuildContext context) {
    return
      
      Scaffold(
        appBar: AppBar(
          title: Text('Completed Sessions'),
        ),
          body: Container(
          height: 50.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                child: Text("Student"),
                width:120.0,
                color:Colors.blue,
              ),

              Container(
                child: Text("Day"),
                width:120.0,
                color:Colors.blue,
              ),

              Container(
                child: Text("Time"),
                width:120.0,
                color:Colors.blue,
              ),

              Container(
                child: Text("Status"),
                width:120.0,
                color:Colors.blue,
              ),
            ],
          ),
        ),
      );
      
  }
}