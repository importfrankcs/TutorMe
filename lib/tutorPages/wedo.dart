import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

final key = new GlobalKey<MyStatefulWidget1State>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new MyStatefulWidget1(key: key),
            
          ],
        ),
      ),
    );
  }
}

class MyStatefulWidget1 extends StatefulWidget {
  MyStatefulWidget1({ Key key }) : super(key: key);
  State createState() => new MyStatefulWidget1State();
}

class MyStatefulWidget1State extends State<MyStatefulWidget1> {
  String _createdObject = "Hello world!";
  String get createdObject => _createdObject;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(_createdObject),
    );
  }
}