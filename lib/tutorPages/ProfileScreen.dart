import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_me_demo/constants.dart';

class ProfileScreen extends StatefulWidget {
  final DocumentReference detailsUserTutor;
  

  ProfileScreen({Key key, @required this.detailsUserTutor}); //super(key: key);
  static String tag = 'screeny';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GoogleSignIn _gSignIn = GoogleSignIn();
  static String tag = 'tutor profile page';
  final String _status = "IFS312";
  final String _bio = "The Dynamic bio is being built\n";
  final int star = 0;

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 4.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/uwc.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return FutureBuilder<DocumentSnapshot>(
      future: widget.detailsUserTutor
          .get(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, snapshot) {
        return Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  snapshot.data == null ? "" : snapshot.data.data["photoURL"],
                  scale: 0.1),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(
              color: Colors.white,
              width: 4.0,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFullName() {
    return FutureBuilder<DocumentSnapshot>(
      future: widget.detailsUserTutor
          .get(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, snapshot) {
        TextStyle _nameTextStyle = TextStyle(
          fontFamily: 'Roboto',
          color: Colors.black,
          fontSize: 28.0,
          fontWeight: FontWeight.w400,
        );

        return Text(
          snapshot.data == null ? "" : snapshot.data.data["displayName"],
          style: _nameTextStyle,
        );
      },
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        //color: Theme.of(context).scaffoldBackgroundColor,
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
          index < star ? Icons.star : Icons.star_border,
        );
      }),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      //color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      //color: Theme.of(context).scaffoldBackgroundColor,
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: widget.detailsUserTutor
          .get(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, snapshot) {
        Size screenSize = MediaQuery.of(context).size;
        return Scaffold(
          backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF285AE6), Color(0xFF41B7FC)]),
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  _gSignIn.signOut();
                  print('Signed out');
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.exit_to_app,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          drawer: ActualDrawer(
            accName: Text(
              snapshot.data == null ? "" : snapshot.data.data["displayName"],
            ),
            accEmail:
                Text(snapshot.data == null ? "" : snapshot.data.data["email"]),
            accImage: NetworkImage(
                snapshot.data == null ? "" : snapshot.data.data["photoURL"]),
          ),
          body: Stack(
            children: <Widget>[
              _buildCoverImage(screenSize),
              Container(
                  margin: EdgeInsets.fromLTRB(170, 130, 0, 0),
                  child: _buildProfileImage()),
              SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(80, 150, 0, 0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: screenSize.height / 14),

                        _buildFullName(),
                        _buildStatus(context),
                        _buildStarRating(),
                        _buildBio(context),
                        _buildSeparator(screenSize),
                        SizedBox(height: 10.0),
                        SizedBox(height: 8.0),
                        // RoundedButton(
                        // title: "SCHEDULE",
                        // onPressed: () {},
                        //)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/*
@override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: widget.detailsUserTutor
          .get(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, snapshot) {
        Size screenSize = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  _gSignIn.signOut();
                  print('Signed out');
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.exit_to_app,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          drawer: ActualDrawer(
            accName: Text(
                snapshot.data == null ? "" : snapshot.data.data["displayName"]),
            accEmail:
                Text(snapshot.data == null ? "" : snapshot.data.data["email"]),
            accImage: NetworkImage(
                snapshot.data == null ? "" : snapshot.data.data["photoURL"]),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }



    return FutureBuilder<DocumentSnapshot>(
      future: widget.detailsUserTutor
          .get(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, snapshot) {
        Size screenSize = MediaQuery.of(context).size;
  },
    );

*/
