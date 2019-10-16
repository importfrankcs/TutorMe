import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_me_demo/tutorPages/ProfileScreen.dart';
import 'package:tutor_me_demo/landing_page.dart';
import 'package:tutor_me_demo/studentPages/profile_page.dart';
import 'package:tutor_me_demo/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Signin APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff9C58D2),
      ),
      home: GoogleSignApp(),
    );
  }
}

class GoogleSignApp extends StatefulWidget {
  static String tag = 'goggle';

  bool type;
  GoogleSignApp({Key key, this.type}) : super(key: key);
  @override
  _GoogleSignAppState createState() => _GoogleSignAppState();
}

class Username {
  String username;
  Username({this.username});
}

final usern = Username(username: 'test');

class Picture {
  String photo;
  Picture({this.photo});
}

final phot = Picture(photo: 'test');

class User {
  DocumentReference mens;
  User({this.mens});
}

final currmens = User(mens: null);

class User2 {
  DocumentReference mens;
  User2({this.mens});
}

final othermens = User(mens: null);

class _GoogleSignAppState extends State<GoogleSignApp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    Scaffold.of(context).showSnackBar(new SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        'Sign in',
        style: TextStyle(color: Colors.black),
      ),
    ));

    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthResult authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    updateUserData(user);
    print("signed in " + user.displayName);
    usern.username = user.displayName;
    phot.photo = user.photoUrl;

    return user;
  }

  Future<void> updateUserData(FirebaseUser user) async {
    DocumentReference refStud = _db.collection('Student').document(user.uid);
    DocumentReference refTut = _db.collection('Tutor').document(user.uid);
    currmens.mens = refTut;
    othermens.mens = refStud;

    refStud.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now(),
      'documentReference': refStud,
      // 'Bio': 'update Bio',
    }, merge: true);

    refTut.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now(),
      'documentReference': refTut,
      //'Bio': 'update Bio',
    }, merge: true);

    if (type.userType) {
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => ProfileScreen(detailsUserTutor: refStud),
        ),
      );
    } else {
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => ProfilePage(detailsUser: refTut),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF285AE6),
                    Color(0xFF41B7FC),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 110, horizontal: 0),
                        child: Icon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                      RoundedButton(
                        onPressed: () async => _signIn(context)
                            .then((FirebaseUser user) => print(user))
                            .catchError((e) => print(e)),
                        colour: Colors.white,
                        title: "SIGN WITH GOOGLE",
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

/*

Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF285AE6),
              Color(0xFF41B7FC),
            ]),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: RoundedButton(
            onPressed: () async => _signIn(context)
                .then((FirebaseUser user) => print(user))
                .catchError((e) => print(e)),
            colour: Colors.white,
            title: "SIGN WITH GOOGLE",
            textColor: Colors.black,
          ),
        ),
      ]),
    );
  }
}
*/

//onPressed: () async => _signIn(context).then((FirebaseUser user) => print(user)).catchError((e) => print(e)),
