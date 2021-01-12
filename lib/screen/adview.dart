import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:getwidget/getwidget.dart';
import 'package:social_share/social_share.dart';
import 'package:velocity_x/velocity_x.dart';

class AdView extends StatefulWidget {
  final String title;
  final String body;
  final String primaryImage;
  final String secondaryImage;
  final String thirdImage;
  AdView(this.title, this.body, this.primaryImage, this.secondaryImage, this.thirdImage);
  @override
  _AdViewState createState() => _AdViewState(this.title, this.body, this.primaryImage, this.secondaryImage, this.thirdImage);
}

class _AdViewState extends State<AdView> {
  String title;
  String body;
  String primaryImage;
  String secondaryImage;
  String thirdImage;

  _AdViewState(this.title, this.body, this.primaryImage, this.secondaryImage, this.thirdImage);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title:  GFShimmer(
          child: Text(
            "Tneos Eduloutions",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            decoration:  BoxDecoration(
              // gradient: FlutterGradients.sunnyMorning(
              //   type: GradientType.radial,
              //   center: Alignment.center,
              // ),
              color: Color(0xff2e2b2b),
            ),
            padding: EdgeInsets.symmetric(vertical:16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GFTypography(
                    text:  title,
                    type: GFTypographyType.typo1,
                    textColor: Colors.white,
                    dividerColor: Colors.white30,
                    icon: Icon(Icons.send, color: Colors.white,),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                  ),
                  child: GFCarousel(
                    autoPlay: true,
                    activeIndicator: Colors.deepOrange,
                    enlargeMainPage: true,
                    items: [primaryImage, secondaryImage != null ? secondaryImage : primaryImage, thirdImage != null ? thirdImage : primaryImage].map(
                          (url) {
                        return Container(
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            child:
                            CachedNetworkImage( fit: BoxFit.cover, width: 1000.0, imageUrl: "http://10.0.2.2:8000/storage/"+url,),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                Container(

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.circular(20.0),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.red,
                    //     blurRadius: 25.0, // soften the shadow
                    //     spreadRadius: 5.0, //extend the shadow
                    //     offset: Offset(
                    //       0.0, // Move to right 10  horizontally
                    //       15.0, // Move to bottom 10 Vertically
                    //     ),
                    //   )
                    // ],
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12.0),
                  margin: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                      ),),
                      SizedBox(height: 20,),

                      Text(body,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[900],
                        fontFamily: "Montserrat",
                      ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GFButton(
                          onPressed: () async {
                            SocialShare.shareWhatsapp(
                                title+", Download Now Tneos Competitive Acacdemy App, Get It On Playstore!, www.playstore.com/TneosAcademy###Testing, https://shop.tneos.com"
                            );
                          },
                          text: "Share",
                          color: Vx.green400,
                          icon: Icon(MaterialCommunityIcons.whatsapp, color: Vx.green600),
                          type: GFButtonType.solid,
                      ),
                      GFButton(
                          onPressed: (){
                            // TODO:: share action
                          },
                          text: "Share",
                          color: Color(0xffD8267B),
                          icon: Icon(MaterialCommunityIcons.instagram, color: Color(0xffECC25C)),
                          type: GFButtonType.solid,
                      ),
                      GFButton(
                          onPressed: (){
                            SocialShare.shareTwitter(
                                title,
                                hashtags: [title],
                                url: "https://shop.tneos.com ",
                                trailingText: "Tneos Competitive Academy Android App, Download Now!");
                          },
                          text: "Share",
                          icon: Icon(MaterialCommunityIcons.twitter, color: Vx.blue400),
                          type: GFButtonType.solid,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
