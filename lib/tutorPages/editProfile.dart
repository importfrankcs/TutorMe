import 'package:tutor_me_demo/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class TutorBioEdit extends StatefulWidget {
  static String tag = "tutoredit";
  @override
  _TutorBioEditState createState() => _TutorBioEditState();
}

class _TutorBioEditState extends State<TutorBioEdit> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit your details"),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            TextFormField(
              controller: myController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: 'EDIT YOUR BIO HERE'),
            )
          ],
        )));
  }
}
