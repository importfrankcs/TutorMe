import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_me_demo/ProfileScreen.dart';
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
  static String  tag = 'goggle';
  bool type;
  GoogleSignApp({Key key,this.type}) : super(key: key);
  
  @override
  _GoogleSignAppState createState() => _GoogleSignAppState();
}

class _GoogleSignAppState extends State<GoogleSignApp> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

Future<FirebaseUser> _signIn(BuildContext context) async {
  
   Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text('Sign in'),
        ));

    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

  //FirebaseUser userDetails = await _firebaseAuth.signInWithCredential(credential);
  //ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
  
    final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    updateUserData(user);
    print("signed in " + user.displayName);
      //loading.add(false);
      return user;
  }
  Future<void> updateUserData(FirebaseUser user) {
    DocumentReference refStud = _db.collection('Student').document(user.uid);
    DocumentReference refTut = _db.collection('Tutor').document(user.uid);
    //MaterialButton(
     if(type.userType){
       Navigator.push(
      context,
      new MaterialPageRoute( 
        
        builder: (context) => ProfileScreen(detailsUserTutor: refTut),
      ),
    );
    return refStud.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);

     }else{
        Navigator.push(
      context,
      new MaterialPageRoute( 
        
        builder: (context) => ProfilePage(detailsUser: refStud),
      ),
    );

    return refTut.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
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
              SizedBox(height:10.0),
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
                      Icon(Icons.exit_to_app,color: Color(0xffCE107C),),
                      SizedBox(width:10.0),
                      Text(
                      'Sign in with Google',
                      style: TextStyle(color: Colors.black,fontSize: 18.0),
                    ),
                    ],),
                    onPressed: () => _signIn(context)
                              .then((FirebaseUser user) => print(user))
                              .catchError((e) => print(e)),
                  ),
                )
                ),

                
               
            ],
          ),
        ],
      ),),
    );
  }
}




























/*
########################################

This code allows me to add user details to firebase however does not allow for the
user to choose different emails upon opening the app

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'dart:async';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();

  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  static String tag = 'LoginPage';

  Future<FirebaseUser> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final AuthResult authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      updateUserData(user);
      
      print("signed in " + user.displayName);
      //loading.add(false);
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> updateUserData(FirebaseUser user) {
    DocumentReference ref = _db.collection('reports').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);

  }

  Future<void> signOut() {
    return _auth.signOut();
  }

}
final AuthService authService = AuthService(); 
*/


