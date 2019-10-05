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
          flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF285AE6), Color(0xFF41B7FC)]),
              ),
            ),
          title: Text('Completed Sessions'),
        ),
          body: Container(
          height: 50.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                child: Text("Student", style: TextStyle(color: Colors.white),),
                width:120.0,
                color:Colors.blue,
              ),

              Container(
                child: Text("Day",style: TextStyle(color: Colors.white)),
                width:120.0,
                color:Colors.blue,
              ),

              Container(
                child: Text("Time",style: TextStyle(color: Colors.white)),
                width:120.0,
                color:Colors.blue,
              ),

              Container(
                child: Text("Status",style: TextStyle(color: Colors.white)),
                width:120.0,
                color:Colors.blue,
              ),
            ],
          ),
        ),
      );
      
  }
}