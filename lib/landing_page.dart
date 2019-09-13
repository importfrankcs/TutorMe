import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_me_demo/constants.dart';




import 'Login_Authentification/LoginPage.dart';




class LandingPage extends StatefulWidget {
  static String tag = 'landing-page';
  @override
  _LandingPageState createState() => new _LandingPageState();
}
class Type{
  bool userType;
  Type({this.userType});
}
final type = Type(userType: true);
class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          children: <Widget>[
            logo,
            SizedBox(height: 100.0),
            RoundedButton(
              type: false,
              title: 'SIGN IN AS A TUTOR',
              colour: Color(0xFF6BCDFD),
              ver: 8,
              //GoogleSignApp
              hor:16,
              onPressed: () {
               //Navigator.pushNamed(context, GoogleSignApp.tag);
               type.userType = true;
               Navigator.push(context, new MaterialPageRoute(
                builder: (context) => GoogleSignApp(type: true)
               ));
              },
            ),
            RoundedButton(
              type: true,
              title: 'SIGN IN AS A STUDENT',
              colour: Color(0xFF6BCDFD),
              ver: 8,
              hor:16,
              onPressed: () {
                type.userType = false;
                Navigator.push(context, new MaterialPageRoute(
                builder: (context) => GoogleSignApp(type: false)
               ));
                //Navigator.pushNamed(context, GoogleSignApp.tag);
              },
            ),
          ],
        ),
      ),
    );
  }
}

