import 'package:flutter/material.dart';
import 'package:tutor_me_demo/main.dart';
import 'package:tutor_me_demo/studentPages/profile_page.dart';
import 'modules_page.dart';

class StudentConsultation extends StatefulWidget {
  @override
  _StudentConsultationState createState() => _StudentConsultationState();
}

class _StudentConsultationState extends State<StudentConsultation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultations'),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('images/profilePic.jpg'),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF6BCDFD),
                ),
                accountEmail: Text('3689674@myuwc.ac.za'),
                accountName: Text('Alex Knox'),
              ),
              FlatButton(
                onPressed: () {
                  /*Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );*/
                },
                child: ListTile(
                  //Todo: Chip and or trialing for alerts!
                  leading: Icon(Icons.account_circle),
                  title: Text('Home Page'),
                ),
              ),
              
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => ModulesPage()),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.question_answer),
                  title: Text('Browse Modules'),
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
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.power_settings_new),
                      title: Text('LogOut'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}