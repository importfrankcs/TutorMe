import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_me_demo/Login_Authentification/LoginPage.dart';
import 'package:tutor_me_demo/constants.dart';
import 'package:tutor_me_demo/tutorPages/editProfile.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tutor_me_demo/tutorPages/tutor_requests.dart';

class ProfileScreen extends StatefulWidget {
  final DocumentReference detailsUserTutor;

  ProfileScreen({Key key, @required this.detailsUserTutor}); //super(key: key);
  static String tag = 'screeny';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

var starcount = 0;
double rating = 0;

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    _loadData();
    super.initState();
    print(_loadData());
  }

  //ar test = initState();

  Future _loadData() async {
    QuerySnapshot snapshot =
        await currmens.mens.collection('CompletedSessions').getDocuments();
    double total =
        snapshot.documents.map<double>((m) => m['uid']).reduce((a, b) => a + b);
    return total;
  }

  static String tag = 'tutor profile page';
  final String _status = "IFS312";
  final String _bio = "";
  final double star = rating;

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
        return Center(
          child: Container(
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
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
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

  Widget _buildCirt() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.cloud_done,
          color: Colors.lightBlueAccent,
          size: 20.0,
        ),
        Text(
          " Certified Tutor",
          style: _nameTextStyle,
        ),
      ],
    );
  }

  void averageStar() {}

  Widget _buildStarRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.blueAccent,
        );
      }),
    );
  }

  Widget _buildemail() {
    return FutureBuilder<DocumentSnapshot>(
      future: widget.detailsUserTutor
          .get(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, snapshot) {
        TextStyle _nameTextStyle = TextStyle(
          fontFamily: 'Roboto',
          fontStyle: FontStyle.italic,
          color: Colors.black,
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        );

        return Text(
          snapshot.data == null ? "" : snapshot.data.data["email"],
          style: _nameTextStyle,
        );
      },
    );
  }

  Widget _buildBio(BuildContext context) {
    return StreamBuilder(
      stream: currmens.mens
          .snapshots(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, snapshot) {
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
          child: snapshot.data['Bio'] != null
              ? new Text(
                  snapshot.data['Bio'],
                  textAlign: TextAlign.center,
                  style: bioTextStyle,
                )
              : new Text('Welcome to TutorMe'),
        );
      },
    );
  }

  Widget _buildvarsity(BuildContext context) {
    return StreamBuilder(
      stream: currmens.mens
          .snapshots(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, snapshot) {
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
          child: snapshot.data['uni'] != null
              ? new Text(
                  snapshot.data['uni'],
                  textAlign: TextAlign.center,
                  style: bioTextStyle,
                )
              : new Text('University of the Western Cape'),
        );
      },
    );
  }

  Future totalLikes() async {
    var respectsQuery = currmens.mens
        .collection('CompletedSessions')
        .document()
        .snapshots()
        .length
        .toString();
    return respectsQuery;
  }

  Widget _About() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    );

    return Text(
      "About me",
      style: _nameTextStyle,
    );
  }

  Widget Email() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Spectral',
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    );

    return Text(
      "Email",
      style: _nameTextStyle,
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
          //backgroundColor: Colors.blueGrey[50],
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
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new TutorBioEdit()));
                },
                icon: Icon(
                  Icons.border_color,
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
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 6.4),
                      _buildProfileImage(),
                      _buildFullName(),
                      _buildCirt(),
                      _buildStarRating(),
                      _buildvarsity(context),
                      _buildSeparator(screenSize),
                      _About(),
                      _buildBio(context),
                      _buildSeparator(screenSize),
                      Email(),
                      _buildemail(),
                      /*FloatingActionButton(
                        onPressed: () {
                          var values = 10;
                          var ty = Future.value(currmens.mens
                              .collection('CompletedSessions')
                              .where("Tutor", isEqualTo: usern.username)
                              .snapshots()
                              .length);
                        },
                      )*/
                    ],
                  ),
                ),
              ),
            ],
          ),
          persistentFooterButtons: <Widget>[
            SizedBox(
              height: 55,
              width: 395,
              child: RoundedButton(
                shapa: 0,
                textColor: Colors.white,
                colour: Colors.blueAccent,
                title: "REQUESTS",
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => RequestsPage()));
                },
              ),
            )
          ],
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
