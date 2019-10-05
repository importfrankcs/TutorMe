import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


import '../constants.dart';


class StudentReviews extends StatefulWidget {
  static String tag = 'Student_Reviews';

  @override
  _StudentReviews createState() => _StudentReviews();
}

class _StudentReviews extends State<StudentReviews> {
  final dio = new Dio();
  var rating = 0.0;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF285AE6), Color(0xFF41B7FC)]),
              ),
            ),
          title: Text('Student Reviews'),
        ),
        
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                child: FittedBox(
                  child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(0.0),
                    shadowColor: Color(0xFF6BCDFD),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text("Ruchen Wyngaard"),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: SmoothStarRating(
                              rating: 4,
                              size: 20,
                              starCount: 5,
                              spacing: 2.0,
                              //onRatingChanged: (value) {
                              //setState(() {
                              //rating = value;
                              //});
                              //},
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 250,
                          child: Container(
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/profile.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    
  }
}
