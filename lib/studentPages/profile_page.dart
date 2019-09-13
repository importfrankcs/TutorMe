//ProfilePage

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:tutor_me_demo/constants.dart';
import 'package:tutor_me_demo/tutorPages/tutor_schedule.dart';





class ProfilePage extends StatefulWidget {
  final DocumentReference detailsUser;
  final Widget respectiveDrawer;
  //detailsUser = FirebaseDatabase.getInstance().getReference();
  ProfilePage({Key key,this.respectiveDrawer, @required this.detailsUser}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  

  

  
  final GoogleSignIn _gSignIn = GoogleSignIn();

  static String tag = 'Student profile page';
  final String _fullName = '';
  final String _status = "INFOMATION SYSTEM STUDENT";
  final String _bio = "NothingSTUD";
      //"\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\"";

  Widget _buildCoverImage(Size screenSize) {
    //print('google name = ' + googlename);
    return Container(
      height: screenSize.height / 4.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/backPic03.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return FutureBuilder<DocumentSnapshot>(
  future: widget.detailsUser.get(), // a previously-obtained Future<String> or null
  builder: (BuildContext context, snapshot) {
    return Center(
      child: Container(
        width: 128.0,
        height: 128.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(snapshot.data == null ? "" : snapshot.data.data["photoURL"]),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 7.0,
          ),
        ),
      ),
    );});
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < 3.8 ? Icons.star : Icons.star_border,
        );
      }),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => Schedule()),
                );
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        4.0, // horizontal, move right 10
                        4.0, // vertical, move down 10
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(80.0),
                  border: Border.all(),
                  color: Colors.lightBlue,
                ),
                child: Center(
                  child: Text(
                    "SCHEDULE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
  future: widget.detailsUser.get(), // a previously-obtained Future<String> or null
  builder: (BuildContext context, snapshot) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF6BCDFD),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
             icon: Icon(
              Icons.exit_to_app,
              size: 20.0,
              color: Colors.white,
              ),
            onPressed: (){
              _gSignIn.signOut();
              print('Signed out');
               Navigator.pop(context);
              
            },
          )

        ],
        /*StudentDrawer({this.accName, this.accEmail, this.accImage});*/
      ),
      drawer: StudentDrawer(
        accName: Text(snapshot.data == null ? "" : snapshot.data.data["displayName"]),
        accEmail: Text(snapshot.data == null ? "" : snapshot.data.data["email"]),
        accImage: NetworkImage(snapshot.data == null ? "" : snapshot.data.data["photoURL"]),
      ),
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 14),
                  _buildProfileImage(),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildStarRating(),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  SizedBox(height: 8.0),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );});
  }
  
}
