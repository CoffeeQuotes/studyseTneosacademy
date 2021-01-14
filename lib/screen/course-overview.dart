import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:getwidget/components/bottom_sheet/gf_bottom_sheet.dart';
import 'dart:ui' as ui;
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/getwidget.dart';
import 'package:velocity_x/velocity_x.dart';

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
  double _rating = 0;

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
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Text(courseTitle, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: 2),),
                  Text("By "+ courseOrganizerName, style: TextStyle(color: Colors.black54, fontStyle: FontStyle.italic),),
                  GFCard(
                    elevation: 10,
                      image: Image(image: CachedNetworkImageProvider("http://10.0.2.2:8000/storage/"+courseImage,)),
                      padding: EdgeInsets.all(0),
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  ),
                  GFRating(
                    value: courseRatings.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _rating = value;
                      });
                    },
                    color: Colors.green,
                  ),

                  GFAccordion(
                      collapsedTitleBackgroundColor: Vx.white.withOpacity(0.6),
                      titlePadding: EdgeInsets.all(20.0),
                      titleChild: Text(courseInstance.toUpperCase(), maxLines: 1, style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),),
                      expandedTitleBackgroundColor: Vx.blue200.withOpacity(0.6),
                      contentChild: Text(instanceDesc, style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Montserrat",
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GFTypography(
                      text: "Demo Videos",
                      type: GFTypographyType.typo1,
                    ),
                   ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GFImageOverlay(
                                    image: CachedNetworkImageProvider("https://images.pexels.com/photos/159983/pexels-photo-159983.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 42.0),
                                    child: Icon(AntDesign.playcircleo, color: Colors.white,),
                                  ),
                                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  child: Text("Video Title 1 Lorem Ipsum Doler Sit amet", maxLines: 2, style: TextStyle(color: Color(0xff282c34), fontFamily: "Montserrat", fontWeight: FontWeight.w700),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("22-Jun-2021", style: TextStyle(fontSize: 8),),
                                ),
                              ],
                            ),
                            color: Colors.white.withOpacity(0.6),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GFImageOverlay(
                                  image: CachedNetworkImageProvider("https://images.pexels.com/photos/1767016/pexels-photo-1767016.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 42.0),
                                    child: Icon(AntDesign.playcircleo, color: Colors.white,),
                                  ),
                                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  child: Text("Video Title 1 Lorem Ipsum Doler Sit amet", maxLines: 2, style: TextStyle(color: Color(0xff282c34), fontFamily: "Montserrat", fontWeight: FontWeight.w700),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("22-Jun-2021", style: TextStyle(fontSize: 8),),
                                ),
                              ],
                            ),
                            color: Colors.white.withOpacity(0.6),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GFImageOverlay(
                                  image: CachedNetworkImageProvider("https://images.pexels.com/photos/610293/pexels-photo-610293.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 42.0),
                                    child: Icon(AntDesign.playcircleo, color: Colors.white,),
                                  ),
                                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  child: Text("Video Title 1 Lorem Ipsum Doler Sit amet", maxLines: 2, style: TextStyle(color: Color(0xff282c34), fontFamily: "Montserrat", fontWeight: FontWeight.w700),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("22-Jun-2021", style: TextStyle(fontSize: 8),),
                                ),
                              ],
                            ),
                            color: Colors.white.withOpacity(0.6),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GFImageOverlay(
                                  image: CachedNetworkImageProvider("https://images.pexels.com/photos/1640784/pexels-photo-1640784.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 42.0),
                                    child: Icon(AntDesign.playcircleo, color: Colors.white,),
                                  ),
                                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  child: Text("Video Title 1 Lorem Ipsum Doler Sit amet", maxLines: 2, style: TextStyle(color: Color(0xff282c34), fontFamily: "Montserrat", fontWeight: FontWeight.w700),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("22-Jun-2021", style: TextStyle(fontSize: 8),),
                                ),
                              ],
                            ),
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ),
          ),
        ),
    );
  }
}
