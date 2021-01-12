import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'dart:ui' as ui;

import 'package:getwidget/components/card/gf_card.dart';

class CourseOverview extends StatefulWidget {

  final String courseTitle;
  final String courseDesc;
  final String courseCode;
  final String courseProvider;
  final String courseImage;
  final String courseStatus;
  final String courseOrganizerName;
  final String coursePrice;
  final int courseRatings;
  final String courseInstance;
  final String instanceName;
  final String instanceDesc;
  CourseOverview(this.courseTitle, this.courseDesc, this.courseCode, this.courseProvider, this.courseImage, this.courseStatus, this.courseOrganizerName, this.coursePrice, this.courseRatings,  this.courseInstance,this.instanceName,this.instanceDesc);
  @override
  _CourseOverviewState createState() => _CourseOverviewState(this.courseTitle, this.courseDesc, this.courseCode, this.courseProvider, this.courseImage, this.courseStatus, this.courseOrganizerName, this.coursePrice, this.courseRatings, this.courseInstance,this.instanceName,this.instanceDesc);
}

class _CourseOverviewState extends State<CourseOverview> {

  String courseTitle;
  String courseDesc;
  String courseCode;
  String courseProvider;
  String courseImage;
  String courseStatus;
  String courseOrganizerName;
  String coursePrice;
  int courseRatings;
  String courseInstance;
  String instanceName;
  String instanceDesc;

  _CourseOverviewState(this.courseTitle, this.courseDesc, this.courseCode, this.courseProvider, this.courseImage, this.courseStatus, this.courseOrganizerName, this.coursePrice, this.courseRatings, this.courseInstance,this.instanceName,this.instanceDesc);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider("http://10.0.2.2:8000/storage/"+courseImage,),
                fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            padding: EdgeInsets.only(top: 40),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(courseTitle, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: 2),),
                  Text("By "+ courseOrganizerName, style: TextStyle(color: Colors.black54, fontStyle: FontStyle.italic),),
                  GFCard(
                      image: Image(image: CachedNetworkImageProvider("http://10.0.2.2:8000/storage/"+courseImage,)),
                      padding: EdgeInsets.all(0),
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  ),
                  GFAccordion(
                      titlePadding: EdgeInsets.all(20.0),
                      title: courseInstance,
                      content: instanceDesc,
                  ),

                ],
              ),
            ),
            ),
          ),
        ),
    );
  }
}
