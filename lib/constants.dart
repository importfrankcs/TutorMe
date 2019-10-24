import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:tutor_me_demo/studentPages/consultation.dart';
import 'package:tutor_me_demo/studentPages/consultation.dart' as prefix0;
import 'package:tutor_me_demo/studentPages/modules_page.dart';
import 'package:tutor_me_demo/studentPages/pick_tut_time.dart';
import 'package:tutor_me_demo/studentPages/tutorList.dart';
import 'package:tutor_me_demo/tutorPages/Tutor_student_reviews.dart';
import 'package:tutor_me_demo/tutorPages/tutor_completed.dart';
import 'package:tutor_me_demo/tutorPages/tutor_modules.dart';
import 'package:tutor_me_demo/tutorPages/tutor_requests.dart';
import 'package:tutor_me_demo/tutorPages/tutor_schedule.dart';
import 'package:flutter_rating/flutter_rating.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.type,
      this.textColor,
      this.title,
      this.colour,
      this.shapa,
      @required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;
  final Color textColor;
  final bool type;
  final double shapa;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(shapa),
      ),
      onPressed: onPressed,
      padding: EdgeInsets.all(12),
      color: colour,
      child: Text(title, style: TextStyle(color: textColor)),
    );
  }
}

class ActualDrawer extends StatefulWidget {
  ActualDrawer({this.accName, this.accEmail, this.accImage});

  final NetworkImage accImage;
  final Widget accEmail;
  final Widget accName;

  @override
  _ActualDrawerState createState() => _ActualDrawerState();
}

class _ActualDrawerState extends State<ActualDrawer> {
  final GoogleSignIn _gSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    CollectionReference reference = Firestore.instance.collection('Requests');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {});
    });

    return Drawer(
      child: Container(
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: widget.accImage,
              ),
              decoration: BoxDecoration(
                  //color: Color(0xFF285AE6), //Color(0xFF6BCDFD),
                  gradient: LinearGradient(
                colors: [Color(0xFF285AE6), Color(0xFF41B7FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              accountEmail: widget.accEmail,
              accountName: widget.accName,
            ),
            DrawerButtonWidget(
              title: 'Requests',
              iconVar: Icon(Icons.today),
              onPressed: () {
                //Navigator.pushNamed(context, RequestsPage.tag);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => RequestsPage()));
              },
            ),
            DrawerButtonWidget(
              title: 'Schedule',
              iconVar: Icon(Icons.schedule),
              onPressed: () {
                //Navigator.pushNamed(context, Schedule.tag);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Schedule()));
              },
            ),
            DrawerButtonWidget(
              title: 'Modules',
              iconVar: Icon(Icons.view_module),
              onPressed: () {
                //Navigator.pushNamed(context, TutorModules.tag);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => TutorModules()));
              },
            ),
            DrawerButtonWidget(
              title: 'Reviews',
              iconVar: Icon(Icons.stars),
              onPressed: () {
                //Navigator.pushNamed(context, StudentReviews.tag);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => StudentReviews()));
              },
            ),
            DrawerButtonWidget(
              title: 'Consultation Sessions',
              iconVar: Icon(Icons.check_circle),
              onPressed: () {
                //Navigator.pushNamed(context, CompletedSessions.tag);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => CompletedSessions()));
              },
            ),
            Divider(),
            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: DrawerButtonWidget(
                    title: 'Log Out',
                    iconVar: Icon(Icons.power_settings_new),
                    onPressed: () {
                      _gSignIn.signOut();
                      print('Signed out');
                      Navigator.pop(context);
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentDrawer extends StatelessWidget {
  final GoogleSignIn _gSignIn = GoogleSignIn();
  StudentDrawer({this.accName, this.accEmail, this.accImage});
  final NetworkImage accImage;
  final Widget accEmail;
  final Widget accName;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: accImage,
              ),
              decoration: BoxDecoration(
                  //color: Color(0xFF285AE6), //Color(0xFF6BCDFD),
                  gradient: LinearGradient(
                colors: [Color(0xFF285AE6), Color(0xFF41B7FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              accountEmail: accEmail,
              accountName: accName,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => ModulesPage()),
                );
              },
              child: ListTile(
                leading: Icon(Icons.search),
                title: Text('Browse Modules'),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => prefix0.MyHomePage()),
                );
              },
              child: ListTile(
                leading: Icon(Icons.question_answer),
                title: Text('Consultation Sessions'),
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('Support'),
              ),
            ),
            Divider(),
            FlatButton(
              onPressed: () {
                _gSignIn.signOut();
                print('Signed out');
                Navigator.pop(context);
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerButtonWidget extends StatelessWidget {
  DrawerButtonWidget({this.title, this.iconVar, @required this.onPressed});

  final String title;
  final Function onPressed;
  final Icon iconVar;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: ListTile(
        leading: iconVar,
        title: Text(title),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}

//
class Review extends StatefulWidget {
  final int size;
  Review({this.size});
  @override
  _ReviewState createState() => new _ReviewState();
}

class RatingVal {
  double rate;
  RatingVal({this.rate});
}

final rates = RatingVal(rate: 0.0);

class _ReviewState extends State<Review> {
  double rating = 0;
  int starCount = 5;

  @override
  Widget build(BuildContext context) {
    return StarRating(
      size: 40,
      rating: rating,
      color: Colors.lightBlueAccent,
      borderColor: Colors.white,
      starCount: starCount,
      onRatingChanged: (rating) => setState(
        () {
          this.rating = rating;
          rates.rate = rating;
        },
      ),
    );
  }
}
