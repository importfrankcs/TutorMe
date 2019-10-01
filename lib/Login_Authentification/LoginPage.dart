import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_me_demo/tutorPages/ProfileScreen.dart';
import 'package:tutor_me_demo/landing_page.dart';
import 'package:tutor_me_demo/studentPages/profile_page.dart';

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

class _GoogleSignAppState extends State<GoogleSignApp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Sign in'),
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
    DocumentReference refStud =  _db.collection('Student').document(user.uid);
    DocumentReference refTut = _db.collection('Tutor').document(user.uid);
    
    refStud.setData({
        'uid': user.uid,
        'email': user.email,
        'photoURL': user.photoUrl,
        'displayName': user.displayName,
        'lastSeen': DateTime.now()
      }, merge: true);

    refTut.setData({
        'uid': user.uid,
        'email': user.email,
        'photoURL': user.photoUrl,
        'displayName': user.displayName,
        'lastSeen': DateTime.now()
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
          builder: (context) =>  ProfilePage(detailsUser: refTut),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10.0),
                Container(
                    width: 250.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Color(0xffffffff),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.exit_to_app,
                              color: Color(0xffCE107C),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                            ),
                          ],
                        ),
                        onPressed: () async => _signIn(context).then((FirebaseUser user) => print(user)).catchError((e) => print(e)),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

